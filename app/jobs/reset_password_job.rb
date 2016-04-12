class ResetPasswordJob
  include SuckerPunch::Job

  def perform(user)
    ActiveRecord::Base.connection_pool.with_connection do
      UserMailer.reset_password(user).deliver_now
    end
  end
end
