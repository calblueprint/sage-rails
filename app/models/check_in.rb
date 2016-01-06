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
  validate :within_valid_semester

  # Relationships
  belongs_to :user
  belongs_to :school
  belongs_to :semester

  # Before saving
  before_create :set_semester

  # Scopes
  scope :school_id, -> school_id { where(school_id: school_id) }
  scope :user_id, -> user_id { where(user_id: user_id) }
  scope :verified, -> verified { where(verified: verified) }
  scope :period, -> start, finish { where("created_at > ? AND created_at < ?", start, finish) }

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

  def add_time
    return unless verified
    user.add_time(calculate_time)
  end

  private

  def within_valid_semester
    current_semester = Semester.current_semester,first
    unless current_semester && current_semester.start < start
      errors.add(:start, "does not fall within a valid semester")
    end

    unless current_semester && current_semester.start < finish
      errors.add(:finish, "does not fall within a valid semester")
    end
  end

  def set_semester
    self.semester_id = Semester.current_semester.first.id
  end
end










