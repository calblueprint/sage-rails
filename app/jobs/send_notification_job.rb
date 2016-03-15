class SendNotificationJob
  include SuckerPunch::Job

  def perform(object, type)
    ActiveRecord::Base.connection_pool.with_connection do
      SendNotifications.new(object, type).send
    end
  end
end
