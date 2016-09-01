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

require 'rails_helper'

RSpec.describe SemesterTask, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
