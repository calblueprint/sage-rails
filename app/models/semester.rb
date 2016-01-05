# == Schema Information
#
# Table name: semesters
#
#  id         :integer          not null, primary key
#  start      :datetime         not null
#  finish     :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Semester < ActiveRecord::Base

  # Validations
  validates :start, presence: true
  validates :finish, date: { after: :start, allow_blank: true }
  validate :has_no_current_semester, on: :create
  validate :has_no_overlap

  # Relationships
  has_many :check_ins

  def self.by_date(date)
    find_by('start <= ? AND finish >= ?', date, date)
  end

  def self.current_semester
    find_by(finish: nil)
  end

  private

  def has_no_current_semester
    if Semester.current_semester
      errors.add(:start, "conflicts with current semester")
    end
  end

  def has_no_overlap
    if Semester.by_date(start)
      errors.add(:start, "has overlapping semester")
    end

    if finish && Semester.by_date(finish)
      errors.add(:finish, "has overlapping semester")
    end
  end
end
