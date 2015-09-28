class Api::BaseController < ApplicationController
  prepend_before_filter :get_authentication_params

  private

  def get_authentication_params
    if auth_token = params[:auth_token].blank? && request.headers["X-AUTH-TOKEN"]
      params[:auth_token] = auth_token
    end

    if email = params[:email].blank? && request.headers["X-AUTH-EMAIL"]
      params[:email] = email
    end
  end
end
