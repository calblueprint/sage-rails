class Api::V1::SessionsController < Devise::SessionsController
  before_filter :ensure_params_exist, only: [:create]

  def create
    user = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_attempt if user.nil?

    if user.valid_password?(params[:user][:password])
      successful_login(user)
    else
      invalid_attempt
    end
  end

  private

  def ensure_params_exist
    return unless params[:user].blank?
    error_response(nil, "Missing user parameter.")
  end

  def invalid_attempt
    error_response(nil, "Incorrect login or password.", 401)
  end

end
