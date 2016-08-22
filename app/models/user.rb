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
#  device_type            :integer
#  device_id              :string
#

class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: /\A[^@\s]+@berkeley.edu\z/i
  validates :school_id, presence: true, on: [:create, :update], if: '!president?'

  # Relationships
  has_many :check_ins, dependent: :destroy
  has_many :announcements, dependent: :nullify
  has_many :user_semesters, dependent: :destroy
  has_many :semesters, through: :user_semesters

  belongs_to :school

  # Scopes
  scope :device_type,      -> device_type { where(device_type: device_type) }
  scope :device_id,        -> device_id { where(device_id: device_id) }
  scope :registered,       -> { where.not(device_id: nil) }
  scope :director_id,      -> director_id { where(director_id: director_id) }
  scope :school_id,        -> school_id { where(school_id: school_id) }
  scope :role,             -> role { where(role: role) }
  scope :verified,         -> verified { where(verified: verified) }
  scope :volunteer_type,   -> type { where(volunteer_type: type) }
  scope :non_director,     -> { where(role: 1, director_id: nil) }
  scope :sort,             -> atttribute, order { order("#{atttribute} #{order}" ) }
  scope :sort_name,        -> { sort("lower(first_name)", "asc").sort("lower(last_name)", "asc") }
  scope :sort_school,      -> { joins(:school).sort("lower(name)", "asc").sort_name }
  scope :semester_id,      -> semester_id { joins(:user_semesters).where('user_semesters.semester_id = ?', semester_id) }

  def self.current_semester
    Semester.current_semester.first ? semester_id(Semester.current_semester.first.id) : User.none
  end

  # Enums

  enum role: [:student, :admin, :president]
  enum volunteer_type: [:volunteer, :one_unit, :two_units]
  enum device_type: [:android, :ios]

  REQ_HOURS = { volunteer: 1, one_unit: 2, two_units: 3 }

  # Misc library code
  mount_uploader :image, ImageUploader

  after_create :send_sign_up_notification

  def name
    "#{first_name} #{last_name}"
  end

  def verify
    update_attribute(:verified, true)
  end

  def promote(role_params, current_user)
    unless current_user.president?
      errors.add(:base, "Only the president can change a user's role.")
      return false
    end

    if role_params[:role].blank? || role_params[:role] > 2
      errors.add(:role, "is invalid")
      return false
    end

    if role_params[:role] == 2
      return update_attributes(role_params) &&
             current_user.update_attribute(:role, User.roles[:admin])
    else
      return update_attributes(role_params)
    end
  end

  def can_create_check_in?
    semester = Semester.current_semester.first
    return semester && UserSemester.find_by(user_id: id, semester_id: semester.id)
  end

  def is_director?
    (admin? || president?) && !director_id.nil?
  end

  #
  # Auth token generators
  #
  def ensure_authentication_token
    update_attribute(:authentication_token, generate_auth_token)
  end

  #
  # Image helpers
  #

  def image_url
    image.url if image
  end

  #
  # Reset password
  #
  def reset_password
    ResetPasswordJob.new.async.perform(self)
  end

  private

  def generate_auth_token
    loop do
      token = Devise.friendly_token
      return token unless User.where(authentication_token: token).first
    end
  end

  def send_sign_up_notification
    unless self.verified
      SendNotificationJob.new.async.perform(self, SendNotifications::SIGN_UP)
    end
  end
end
