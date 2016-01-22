# == Schema Information
#
# Table name: semesters
#
#  id         :integer          not null, primary key
#  start      :datetime         not null
#  finish     :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  season     :integer
#

class Semester < ActiveRecord::Base

  # Validations
  validates :start, presence: true
  validates :season, presence: true
  validates :finish, date: { after: :start, allow_blank: true }
  validate :has_no_current_semester, on: :create
  validate :has_no_overlap

  # Relationships
  has_many :check_ins
  has_many :user_semesters
  has_many :users, through: :user_semesters

  # Enums
  enum season: [:fall, :spring]

  # Scopes
  scope :current_semester, -> { where(finish: nil).where('start < ?', Time.now) }
  scope :sort,             -> attribute, order { order("#{attribute} #{order}" ) }
  scope :user_id,          -> user_id { joins(:user_semesters).where('user_semesters.user_id = ?', user_id) }

  def self.by_date(date)
    find_by('start <= ? AND finish >= ?', date, date)
  end

  def self.has_current_semester?
    !current_semester.blank?
  end

  #
  # Finishing helpers
  #
  def finish_semester
    FinishSemesterJob.new.async.perform(self)
  end

  private

  def has_no_current_semester
    if Semester.has_current_semester?
      errors.add(:start, "conflicts with current semester")
    end
  end

  def has_no_overlap
    if Semester.by_date(start)
      errors.add(:start, "has overlapping semester")
    end

    if finish && Semester.by_date(finish)
      errors.add(:finish, "has overlapping semester")
    end
  end
end
