class SendNotifications

  ANNOUNCEMENT = 0
  CHECK_IN = 1
  SIGN_UP = 2

  attr_accessor :object, :type, :title, :message

  def initialize(object, type)
    @object = object
    @type = type
    @title = ''
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

  end

  def send_check_in_notification
  end

  def send_sign_up_notification

  end

  private

  def send_notification(user)

  end

  def send_android_notification(user)
  end

  def send_ios_notification(user)

  end
end
