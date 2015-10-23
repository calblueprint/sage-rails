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
#  total_time             :integer          default(0)
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
  validates :school_id, presence: true
  validates :image, presence: true

  # Relationships
  has_many :check_ins
  has_many :announcements

  belongs_to :school

  # Scopes
  scope :school_id, -> school_id { where(school_id: school_id) }
  scope :role, -> role { where(role: role) }
  scope :verified, -> verified { where(verified: verified) }
  scope :volunteer_type, -> type { where(volunteer_type: type) }

  enum role: [:student, :admin]
  enum volunteer_type: [:volunteer, :one_units, :two_units]

  mount_uploader :image, ImageUploader

  #
  # Auth token generators
  #
  def ensure_authentication_token
    if authentication_token.blank?
      update_attribute(:authentication_token, generate_auth_token)
    end
  end

  private

  def generate_auth_token
    loop do
      token = Devise.friendly_token
      return token unless User.where(authentication_token: token).first
    end
  end

  #
  # Image helpers
  #

  def image_url
    image_tmp_url || image.url
  end

  def image_tmp_url
    "/tmp/uploads/#{image_tmp}" unless image_tmp.nil?
  end

  def self.convert_base64(data)
    return unless data

    temp_file = Tempfile.new [Devise.friendly_token, "jpg"]
    temp_file.binmode
    temp_file.write(Base64.decode64(data))

    ActionDispatch::Http::UploadedFile.new(tempfile: temp_file, filename: "#{Devise.friendly_token}.jpg")
  end
end
