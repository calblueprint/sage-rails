class Api::V1::Admin::UsersController < Api::V1::BaseController
  prepend_before_filter :convert_base64_to_images, only: [:create]
  load_and_authorize_resource

  def create
    if @user.save
      render json: @user, serializer: UserSerializer
    else
      error_response(@user)
    end
  end

  def promote
    if @user.update_attributes(role_params)
      render json: @user, serializer: UserSerializer
    else
      error_response(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :role, :school_id, :volunteer_type, :verified,
                                 :password, :current_password, :password_confirmation,
                                 :image)
  end

  def role_params
    params.require(:user).permit(:role)
  end

  def convert_base64_to_images
    unless params[:user][:data].blank?
      params[:user][:image] = PhotoUtils.convert_base64(params[:user][:data])
    end
    params[:user].delete(:data)
  end
end
