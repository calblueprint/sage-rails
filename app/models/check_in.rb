# == Schema Information
#
# Table name: check_ins
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  start       :datetime         not null
#  finish      :datetime         not null
#  school_id   :integer
#  user_id     :integer
#  verified    :boolean          default(FALSE)
#  comment     :text
#  semester_id :integer
#

class CheckIn < ActiveRecord::Base
  # Validations
  validates :start, date: true
  validates :finish, date: { after: :start }
  validates :school_id, presence: true
  validates :user_id, presence: true
  validate :not_uc_berkeley
  validate :within_valid_semester
  validate :contains_comment

  # Relationships
  belongs_to :user
  belongs_to :school
  belongs_to :semester

  # Before saving
  before_create :set_semester
  after_create :add_time
  after_create :send_check_in_notification

  # Scopes
  scope :school_id,   -> school_id { where(school_id: school_id) }
  scope :user_id,     -> user_id { where(user_id: user_id) }
  scope :semester_id, -> semester_id { where(semester_id: semester_id) }
  scope :verified,    -> verified { where(verified: verified) }
  scope :sort,        -> atttribute, order { order("#{atttribute} #{order}" ) }
  scope :sort_school, -> { joins(:school).joins(:user).sort("lower(name)", "asc").sort("lower(first_name)", "asc").sort("lower(last_name)", "asc") }
  scope :between,     -> start, finish { where('? <= created_at AND created_at <= ?', start, finish) }

  def self.current_semester
    current_semester = Semester.current_semester.first
    return none unless current_semester

    where(semester_id: current_semester.id)
  end

  # Check in helpers
  def calculate_time
    ((finish - start) / 60).to_i
  end

  def verify
    return true if verified
    if update_attribute(:verified, true)
      add_time
    end
  end

  private

  def within_valid_semester
    current_semester = Semester.current_semester.first
    unless current_semester && current_semester.start < start
      errors.add(:start, "does not fall within a valid semester")
    end

    unless current_semester && current_semester.start < finish
      errors.add(:finish, "does not fall within a valid semester")
    end
  end

  def contains_comment
    unless verified || comment
      errors.add(:comment, "cannot be blank")
    end
  end

  def not_uc_berkeley
    unless school_id != 1
      errors.add(:school, "cannot be UC Berkeley")
    end
  end

  def set_semester
    self.semester_id = Semester.current_semester.first.id
  end

  def add_time
    user_semester = UserSemester.find_by user_id: user_id,
                                         semester_id: semester_id
    return unless verified && user_semester
    user_semester.add_time(calculate_time)
  end

  def send_check_in_notification
    unless self.verified
      SendNotificationJob.new.async.perform(self, SendNotifications::CHECK_IN)
    end
  end
end
