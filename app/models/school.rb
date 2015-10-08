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
#

class School < ActiveRecord::Base
  # Validations

  # Relationships
  has_many :check_ins
  has_many :users
  has_one :director, class_name: User, foreign_key: :director_id
end
