# == Schema Information
#
# Table name: check_ins
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  start      :datetime         not null
#  finish     :datetime         not null
#  school_id  :integer
#  user_id    :integer
#

class CheckIn < ActiveRecord::Base
  def calculate_time
    ((finish - start) / 60).to_i
  end
end
