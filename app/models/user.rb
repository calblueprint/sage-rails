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
  scope :semester_id,    -> semester_id { joins(:user_semesters).where('user_semesters.semester_id = ?', semester_id) }

  # Callbacks
  after_create :set_semester

  enum role: [:student, :admin, :president]
  enum volunteer_type: [:volunteer, :one_unit, :two_units]

  REQ_HOURS = { volunteer: 1, one_unit: 2, two_units: 3 }

  mount_uploader :image, ImageUploader

  def verify
    update_attribute(:verified, true)
  end

  def promote(role_params, current_user)
    if role_params[:role].blank? || role_params[:role] > 2
      errors.add(:role, "is invalid")
      return false
    end

    if role_params[:role] > 1 && !current_user.president?
      errors.add(:role, "could not be changed")
      return false
    end

    if role_params[:role] == 2 && current_user.president?
      return update_attribute(:role, User.roles[:president]) &&
      current_user.update_attribute(:role, User.roles[:admin])
    else
      return update_attributes(role_params)
    end
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
    self.semesters << semester
  end
end
