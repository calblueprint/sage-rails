require 'csv'
class ExportSemester

  HEADERS = ['Name', 'Email', 'Check in count', 'Units', 'Total Hours', 'Hours required', 'Completed?']
  attr_reader :semester, :user

  def initialize(semester, user)
    @semester = semester
    @user = user
    @hours_map = User::REQ_HOURS.map do |k, v|
      [k.to_s, v * @semester.weeks_completed]
    end.to_h
  end

  def export
    csv = @user.president? ? generate_all_csv : generate_school_csv
    SemesterMailer.export_semester(@semester, @user, csv).deliver_now
  end

  def generate_school_csv
    return unless @user.director_id
    mentors = User.school_id(@user.director_id)
    mentor_semesters = mentors.map do |mentor|
      UserSemester.find_by user_id: mentor.id,
                           semester_id: @semester.id
    end.compact
    generate_csv(mentor_semesters)
  end

  def generate_all_csv
    generate_csv(UserSemester.semester_id(@semester.id))
  end

  def generate_csv(user_semesters)
    CSV.generate do |csv|
      csv << HEADERS
      user_semesters.each do |user_semester|
        row = generate_row(user_semester)
        csv << row if row
      end
    end
  end

  def generate_row(user_semester)
    user = user_semester.user
    return unless user

    check_in_size = user.check_ins
                        .where(user_id: user.id, semester_id: @semester.id)
                        .size

    [
      user_semester.user.name,
      user_semester.user.email,
      check_in_size,
      User.volunteer_types[user_semester.user.volunteer_type],
      user_semester.formatted_total_time,
      "#{@hours_map[user.volunteer_type]} hrs",
      user_semester.completed?
    ]
  end
end
