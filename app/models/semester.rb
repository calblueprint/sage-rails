# == Schema Information
#
# Table name: semesters
#
#  id         :integer          not null, primary key
#  start      :datetime         not null
#  finish     :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  year       :integer
#  season     :integer
#

class Semester < ActiveRecord::Base
  # Validations
  validates :start, presence: true, date: { before: :finish }
  validates :finish, presence: true, date: { after: :start }
  validates :year, presence: true, numericality: { only_integer: true, greater_than: 2014 }
  validates :season, presence: true, numericality: { only_integer: true }
  validate :has_no_overlap

  validates_uniqueness_of :year, scope: :season

  # Scopes
  scope :by_period, -> year, season { where(year: year, season: season) }

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
