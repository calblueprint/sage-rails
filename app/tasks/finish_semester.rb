class FinishSemester
  def initialize(semester)
    @semester = semester
    @hours_map = User::REQ_HOURS.map do |k, v|
      [k.to_s, v * get_num_weeks(semester)]
    end.to_h
  end

  def perform
    @semester.user_semesters.each do |u|
      next unless u.user.school_id
      u.update_attribute(:completed, has_completed_semester?(u))
    end
  end

  def get_num_weeks(semester)
    (semester.finish - semester.start).ceil / 60 / 60 / 24 / 7
  end

  def has_completed_semester?(user_semester)
    hours_required = @hours_map[user_semester.user.volunteer_type]

    user_semester.active? &&
    user_semester.total_time >= hours_required
  end
end
