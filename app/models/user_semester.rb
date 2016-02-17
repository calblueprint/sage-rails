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

  scope :semester_id, -> semester_id { where(semester_id: semester_id) }
  scope :user_id,     -> user_id { where(user_id: user_id) }

  def add_time(time)
    self.total_time += time
    save
  end

  def hours_required
    hours_per_week = User::REQ_HOURS[user.volunteer_type.to_sym]
    weeks_so_far = (((semester.finish || Time.now) - semester.get_first_sunday) / 60 / 60 / 24 / 7).to_i
    weeks_so_far * hours_per_week
  end
end
