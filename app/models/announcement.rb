# == Schema Information
#
# Table name: announcements
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :string           default(""), not null
#  body        :text             default(""), not null
#  school_id   :integer
#  user_id     :integer          not null
#  category    :integer
#  semester_id :integer
#

class Announcement < ActiveRecord::Base
  # Validations
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
  validates :category, presence: true

  # Relationships
  belongs_to :user
  belongs_to :school

  # Scope
  scope :school_id, -> school_id { where(school_id: school_id) }
  scope :user_id, -> user_id { where(user_id: user_id) }
  scope :type, -> type { where(category: type) }

  # Callbacks
  before_create :set_semester

  enum category: [:school, :general]

  private

  def set_semester
    current_semester = Semester.current_semester
    if current_semester
      self.semester_id = current_semester
    end
  end
end
