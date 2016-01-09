# == Schema Information
#
# Table name: user_semesters
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  semester_id :integer
#  completed   :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserSemester < ActiveRecord::Base
end
