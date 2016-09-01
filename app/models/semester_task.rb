# == Schema Information
#
# Table name: semester_tasks
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  set_active     :boolean          default(FALSE)
#  increment_week :boolean          default(FALSE)
#

class SemesterTask < ActiveRecord::Base
  scope :between, -> start, finish { where('? <= created_at AND created_at <= ?', start, finish) }
end
