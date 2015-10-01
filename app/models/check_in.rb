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
#  verified   :boolean          default(FALSE)
#  comment    :text
#

class CheckIn < ActiveRecord::Base

  validates :start, date: true
  validates :finish, date: { after: :start }

  belongs_to :user

  def calculate_time
    ((finish - start) / 60).to_i
  end

  def verify
    update_attribute(:verified, true)
  end
end
