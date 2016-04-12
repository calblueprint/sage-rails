# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           default(""), not null
#  lat        :decimal(10, 7)   default(0.0)
#  lng        :decimal(10, 7)   default(0.0)
#  address    :string
#  radius     :integer          default(200)
#

class School < ActiveRecord::Base
  # Validations
  validates_presence_of :address, :name

  # Relationships
  has_many :check_ins, dependent: :nullify
  has_many :users, dependent: :nullify
  has_many :announcements, dependent: :nullify
  has_one :director, class_name: User, foreign_key: :director_id, dependent: :nullify

  # Scopes
  scope :sort, -> atttribute, order { order("#{atttribute} #{order}" ) }

  def set_director(user)
    self.director = user
    user.update_attribute(:school_id, id) if save && user
  end
end
