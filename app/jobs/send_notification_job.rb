class SendNotificationJob
  include SuckerPunch::Job

  def perform()
    ActiveRecord::Base.connection_pool.with_connection do
      FinishSemester.new(semester).perform
    end
  end
end
