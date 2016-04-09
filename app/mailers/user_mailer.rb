class UserMailer < ActionMailer::Base
  def reset_password(user)
    @password = Devise.friendly_token.first(8)
    @user = user

    @user.password = @password
    @user.save

    mail(to: @user.email, subject: 'SAGE password reset')

  end
end

