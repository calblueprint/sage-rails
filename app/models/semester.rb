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
  validates :start, presence: true
  validates :finish, presence: true
end
