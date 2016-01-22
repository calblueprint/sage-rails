class FinishSemesterJob
  include SuckerPunch::Job

  def perform(semester)
    ActiveRecord::Base.connection_pool.with_connection do
      FinishSemester.new(semester).perform
    end
  end
end
