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
  validate :has_correct_category

  # Relationships
  belongs_to :user
  belongs_to :school

  # Callbacks
  before_create :set_semester

  enum category: [:school, :general]

  # Scope
  scope :school_id, -> school_id { where(school_id: school_id) }
  scope :user_id,   -> user_id { where(user_id: user_id) }
  scope :category,  -> category { where(category: category) }
  scope :type,      -> type { where(category: type) }
  scope :sort,      -> atttribute, order { order("#{atttribute} #{order}" ) }

  def self.current_semester
    current_semester = Semester.current_semester.first
    return none unless current_semester

    where(semester_id: current_semester.id)
  end

  def self.default(school_id)
    where('school_id = ? OR category = ?', school_id, Announcement.categories[:general])
  end

  private

  def has_correct_category
    unless do_categories_match?
      errors.add(:category, "is invalid.")
    end
  end

  def do_categories_match?
    ((school_id.blank? || school_id == 0) && general?) ||
    (!school_id.blank? && school_id > 0 && school?)
  end

  def set_semester
    current_semester = Semester.current_semester.first
    if current_semester
      self.semester_id = current_semester.id
    end
  end
end
