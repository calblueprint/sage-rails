# == Schema Information
#
# Table name: semester_pauses
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  date_paused :datetime
#  semester_id :integer
#

class SemesterPause < ActiveRecord::Base
  belongs_to :semester

  scope :between, -> start, finish { where('? <= date_paused AND date_paused <= ?', start, finish) }
end
