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
#

class Announcement < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
end
