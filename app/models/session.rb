# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  start      :datetime         not null
#  finish     :datetime         not null
#  school_id  :integer
#  user_id    :integer
#

class Session < ActiveRecord::Base
  def calculate_time

  end
end
