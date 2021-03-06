class SendNotifications

  ANNOUNCEMENT = 0
  CHECK_IN = 1
  SIGN_UP = 2

  attr_accessor :object, :type, :message, :object_json

  def initialize(object, type)
    @object = object
    @type = type
    @message = ''
  end

  def send
    case @type
    when ANNOUNCEMENT
      send_announcement_notification
    when CHECK_IN
      send_check_in_notification
    when SIGN_UP
      send_sign_up_notification
    end
  end

  def send_announcement_notification
    @message = "#{@object.user.first_name} posted a new #{@object.category} announcement."
    @object_json = AnnouncementSerializer.new(@object).to_json

    users = object.general? ?
              User.verified(true).registered.semester_id(@object.semester_id).reject { |u| u == @object.user } :
              User.verified(true).registered.semester_id(@object.semester_id).school_id(@object.school.id).reject { |u| u == @object.user }

    send_notification(users) unless users.blank?
  end

  def send_check_in_notification
    check_in_size = CheckIn.verified(false).school_id(@object.school_id).size

    @message = "You have #{check_in_size} check in requests."
    @object_json = CheckInSerializer.new(@object).to_json

    if @object.school.director && @object.school.director.device_id
      send_notification([@object.school.director])
    end
  end

  def send_sign_up_notification
    sign_up_size = User.verified(false).school_id(@object.school_id).size

    @message = "You have #{sign_up_size} unverified user requests."
    @object_json = UserSerializer.new(@object).to_json

    if @object.school.director && @object.school.director.device_id
      send_notification([@object.school.director])
    end
  end

  private

  def send_notification(users)
    send_android_notification(get_devices(users, :android))
    send_ios_notification(get_devices(users, :ios))

    Rpush.push
  end

  def get_devices(users, type)
    users.select { |u| u[:device_type] == User.device_types[type] }.map(&:device_id)
  end

  def send_android_notification(registration_ids)
    return if registration_ids.blank?

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name(ENV["GCM_NAME"])
    n.registration_ids = registration_ids
    n.priority = 'high'
    n.data = {
      message: @message,
      type: @type,
      object: @object_json
    }

    n.save!
  end

  def send_ios_notification(registration_ids)
    registration_ids.each do |registration_id|
      n = Rpush::Apns::Notification.new
      n.app = Rpush::Apns::App.find_by_name(ENV["APNS_NAME"])
      n.device_token = registration_id
      n.alert = @message
      n.badge = 1
      n.data = {
        type: @type,
        object: @object_json
      }
      n.save!
    end
  end
end
