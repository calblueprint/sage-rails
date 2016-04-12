class ExportSemesterJob
  include SuckerPunch::Job

  def perform(semester, user)
    ActiveRecord::Base.connection_pool.with_connection do
      ExportSemester.new(semester, user).export
    end
  end
end
