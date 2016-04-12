require 'csv'
class ExportSemester

  HEADERS = ['Name', 'Email', 'Check in count', 'Units', 'Total Hours', 'Hours required', 'Completed?']
  attr_reader :semester, :user

  def initialize(semester, user)
    @semester = semester
    @user = user
  end

  def export
    SemesterMailer.export_semester(@semester, @user, generate_csv).deliver_now
  end

  def generate_csv
    CSV.generate do |csv|
      csv << HEADERS
      UserSemester.semester_id(@semester.id).each do |user_semester|
        csv << generate_row(user_semester)
      end
    end
  end

  def generate_row(user_semester)
    check_in_size = user_semester.user
                                 .check_ins
                                 .where(user_id: user.id, semester_id: @semester.id)
                                 .size

    [
      user_semester.user.name,
      user_semester.user.email,
      check_in_size,
      User::REQ_HOURS[user_semester.user.volunteer_type],
      user_semester.formatted_total_time,
      "#{user_semester.hours_required} hrs",
      user_semester.completed?
    ]
  end
end
