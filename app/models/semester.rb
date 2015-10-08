# == Schema Information
#
# Table name: semesters
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  start      :datetime         not null
#  finish     :datetime         not null
#

class Semester < ActiveRecord::Base
  # Validations
  validates :start, presence: true
  validates :finish, presence: true
end
