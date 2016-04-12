require 'csv'
class ExportSemester

  HEADERS = ['Name', 'Email', 'Check in count', 'Units', 'Total Hours', 'Hours required', 'Completed?']
  attr_reader :semester, :user

  def initialize(semester, user)
    @semester = semester
    @user = user
  end

  def export
    SemesterMailer.export_semester(@semester, csv).deliver
  end

  def generate_csv
    CSV.generate do |csv|
      csv << HEADERS
      User.all.each { |user| csv << generate_row(user) }
    end
  end

  def generate_row(user)
    user_semester = user.user_semesters.find_by(id: @semester.id)
    return unless user_semester

    check_in_size = user.check_ins.where(user_id: user.id, semester_id: @semester.id).size

    [
      user.name,
      user.email,
      check_in_size,
      User::REQ_HOURS[user.volunteer_type],
      user_semester.formatted_total_time,
      "#{user_semester.hours_required} hrs",
      user_semester.completed?
    ]
  end
end
