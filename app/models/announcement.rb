# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string           default(""), not null
#  body       :text             default(""), not null
#  school_id  :integer          not null
#  user_id    :integer          not null
#  category   :integer
#

class Announcement < ActiveRecord::Base
  belongs_to :user
  belongs_to :school

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  # Scope
  scope :school_id, -> school_id { where(school_id: school_id) }
  scope :user_id, -> user_id { where(user_id: user_id) }
end
