class SetActiveJob
  include SuckerPunch::Job

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      SetActive.new.perform
    end
  end
end
