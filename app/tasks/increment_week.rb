class IncrementWeek

  attr_accessor :semester

  def initialize
    @semester = Semester.current_semester.first
  end

  def perform
    Rails.logger.info("Starting increment week job")

    return unless @semester

    if @semester.paused
      @semester.unpause
    else
      @semester.increment_week
    end

    Rails.logger.info("Finished increment week job")
  end
end
