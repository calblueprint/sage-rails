class FinishSemesterJob
  include SuckerPunch::Job

  def perform(semester)
    semester.user_semesters.each do |semester|
  end
end
