# == Schema Information
#
# Table name: semesters
#
#  id         :integer          not null, primary key
#  start      :datetime         not null
#  finish     :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Semester < ActiveRecord::Base

  # Validations
  validates :start, presence: true, date: { before: :finish }
  validates :finish, presence: true, date: { after: :start }
  validate :has_no_overlap

  # Relationships
  has_many :check_ins

  def self.by_date(date)
    find_by('start <= ? AND finish >= ?', date, date)
  end

  def has_no_overlap
    unless Semester.by_date(start)
      errors.add(:start, "has overlapping semester")
    end

    unless Semester.by_date(finish)
      errors.add(:finish, "has overlapping semester")
    end
  end
end
