class ApplicationController < ActionController::Base
  # Prevent CSRF attacks with a null session.
  # For applications, you may want to use :exception instead.
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    unauthorized_response
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    not_found_response
  end

  def successful_login(user)
    sign_in(:user, user)
    user.ensure_authentication_token
    render json: user, serializer: SessionSerializer
  end

  def unauthorized_response
    error_response(nil, "Unauthorized", 403)
  end

  def not_found_response
    error_response(nil, "Not Found", 404)
  end

  def success_response(message = nil)
    render json: Success.new(message), serializer: SuccessSerializer
  end

  def error_response(object, message = nil, status = nil)
    render json: Error.new(object, message), serializer: ErrorSerializer, status: status || 400
  end
end
