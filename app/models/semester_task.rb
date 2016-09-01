# == Schema Information
#
# Table name: semester_tasks
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  set_active     :boolean
#  increment_week :boolean
#

class SemesterTask < ActiveRecord::Base
end
