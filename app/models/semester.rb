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

  validates_uniqueness_of :year, scope: :season
end
