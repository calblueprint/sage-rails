class IncrementWeek

  attr_accessor :semester

  def initialize
    @semester = Semester.current_semester.first
  end

  def perform
    Rails.logger.info("Starting increment week job")

    unless @semester
      Rails.logger.info("No current semester")
      return
    end

    if @semester.paused
      Rails.logger.info("Semester paused, unpausing")

      @semester.unpause
      @semester.semester_pauses.create(date_paused: Time.now)
    else
      Rails.logger.info("Semester not paused, incrementing week")
      @semester.increment_week
    end

    Rails.logger.info("Finished increment week job")
  end
end
