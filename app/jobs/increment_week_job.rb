class IncrementWeekJob
  include SuckerPunch::Job

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      IncrementWeek.new.perform
    end
  end
end
