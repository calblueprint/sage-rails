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
#  total_time  :integer          default(0)
#  status      :integer          default(1)
#

class UserSemester < ActiveRecord::Base
  belongs_to :user
  belongs_to :semester

  enum status: [:inactive, :active]

  def add_time(time)
    self.total_time += time
    save
  end
end
