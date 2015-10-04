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
end
