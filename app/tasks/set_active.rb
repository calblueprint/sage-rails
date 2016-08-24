class SetActive
  def initialize
    @semester = Semester.current_semester.first
  end

  def perform
    Rails.logger.info("Starting set active job")

    return unless should_check_active?

    @semester.user_semesters.each do |u|
      next unless u.user.school

      status = has_check_in?(u.user) ? UserSemester.statuses[:active]
                                     : UserSemester.statuses[:inactive]
      u.update_attribute(:status, status)
    end

    Rails.logger.info("Finished set active job")
  end

  private

  def should_check_active?
    @semester && @semester.start <= Time.now - 2.weeks
  end

  def has_check_in?(user)
    CheckIn.between(get_start_time, Time.now)
           .verified(true)
           .where(semester_id: @semester.id, user_id: user.id)
           .size > 0
  end

  def get_start_time
    num_pauses = @semester.semester_pauses.between(Time.now - 2.weeks, Time.now).size
    Time.now - 2.weeks - num_pauses.weeks
  end
end
