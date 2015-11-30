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
  # Validations
  validates :start, date: true
  validates :finish, date: { after: :start }

  # Relationships
  belongs_to :user
  belongs_to :school

  # Scopes
  scope :school_id, -> school_id { where(school_id: school_id) }
  scope :user_id, -> user_id { where(user_id: user_id) }
  scope :verified, -> verified { where(verified: verified) }
  scope :period, -> start, finish { where("created_at > ? AND created_at < ?", start, finish) }

  def calculate_time
    ((finish - start) / 60).to_i
  end

  def verify
    return true if verified
    if update_attribute(:verified, true)
      add_time
    end
  end

  def add_time
    return unless verified
    user.add_time(calculate_time)
  end
end
