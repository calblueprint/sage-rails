class IncrementWeek

  attr_accessor :semester

  def initialize
    @semester = Semester.current_semester.first
  end

  def perform
    return unless @semester

    if @semester.paused
      @semester.unpause
    else
      @semester.increment_week
    end
  end
end
