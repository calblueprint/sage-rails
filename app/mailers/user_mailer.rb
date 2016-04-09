class UserMailer < ActionMailer::Base
  default from: 'sage-no-reply@blueprint.org'

  def reset_password(user)
    @password = Devise.friendly_token.first(8)
    @user = user

    @user.password = @password
    @user.save

    mail(to: @user.email, subject: 'SAGE password reset')
  end
end

