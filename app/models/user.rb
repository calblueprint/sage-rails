# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  verified               :boolean          default(FALSE), not null
#  first_name             :string           default("")
#  last_name              :string           default("")
#  authentication_token   :string
#  role                   :integer          default(0)
#  school_id              :integer
#  director_id            :integer
#  volunteer_type         :integer          default(0)
#  image                  :string
#

class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  # Relationships
  has_many :check_ins
  has_many :announcements
  has_many :user_semesters
  has_many :semesters, through: :user_semesters

  belongs_to :school

  # Scopes
  scope :director_id,    -> director_id { where(director_id: director_id) }
  scope :school_id,      -> school_id { where(school_id: school_id) }
  scope :role,           -> role { where(role: role) }
  scope :verified,       -> verified { where(verified: verified) }
  scope :volunteer_type, -> type { where(volunteer_type: type) }
  scope :non_director,   -> { where(role: 1, director_id: nil) }
  scope :sort,           -> atttribute, order { order("#{atttribute} #{order}" ) }
  scope :sort_name,      -> { sort("first_name", "asc").sort("last_name", "asc") }

  # Callbacks
  before_create :set_semester

  enum role: [:student, :admin]
  enum volunteer_type: [:volunteer, :one_unit, :two_units]

  REQ_HOURS = { volunteer: 1, one_unit: 2, two_units: 3 }

  mount_uploader :image, ImageUploader

  module Roles
    ADMIN = 1
    STUDENT = 0
  end

  def verify
    update_attributes({ verified: true, status: User.statuses[:active] })
  end

  #
  # Auth token generators
  #
  def ensure_authentication_token
    if authentication_token.blank?
      update_attribute(:authentication_token, generate_auth_token)
    end
  end

  #
  # Image helpers
  #

  def image_url
    image.url if image
  end

  private

  def generate_auth_token
    loop do
      token = Devise.friendly_token
      return token unless User.where(authentication_token: token).first
    end
  end

  def set_semester
    semester = Semester.current_semester.first
    return unless semester
    self.semester_id = semester.id
  end
end
