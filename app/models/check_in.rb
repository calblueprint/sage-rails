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
  validate :within_current_semester

  # Relationships
  belongs_to :user
  belongs_to :school
  belongs_to :semester

  # Scopes
  scope :school_id, -> school_id { where(school_id: school_id) }
  scope :user_id, -> user_id { where(user_id: user_id) }
  scope :verified, -> verified { where(verified: verified) }
  scope :period, -> start, finish { where("created_at > ? AND created_at < ?", start, finish) }

  # Before saving
  before_create :set_semester

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
    unless Semester.by_date(start)
      errors.add(:start, "does not fall within a valid semester")
    end

    unless Semester.by_date(finish)
      errors.add(:finish, "does not fall within a valid semester")
    end
  end

  def set_semester
    semester = Semester.current_semester
  end
end










