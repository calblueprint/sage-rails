class Api::V1::UsersController < Api::V1::BaseController
  # If we're creating a user, we want to skip the user validations
  prepend_before_filter :convert_base64_to_images, only: [:create, :update]
  skip_before_filter :authenticate_user_from_token!, only: [:create, :reset]
  skip_before_filter :authenticate_api_v1_user!,     only: [:create, :reset]

  load_and_authorize_resource

  # Scopes
  has_scope :semester_id
  has_scope :school_id
  has_scope :role
  has_scope :page
  has_scope :non_director, type: :boolean
  has_scope :sort_name, type: :boolean
  has_scope :sort_school, type: :boolean
  has_scope :current_semester, type: :boolean
  has_scope :verified, type: :boolean, allow_blank: true
  has_scope :sort, using: [:attr, :order], type: :hash

  def index
    render json: apply_scopes(User).all, params: params, each_serializer: UserListSerializer
  end

  def show
    render json: @user, params: params, serializer: UserSerializer
  end

  def create
    if @user.save
      successful_login(@user)
    else
      error_response(@user)
    end
  end

  def update
    if @user.update_with_password(update_params)
      render json: @user, serializer: UserSerializer
    else
      error_response(@user)
    end
  end

  def destroy
    if @user.destroy
      render json: @user, serializer: UserSerializer
    else
      error_response(@user)
    end
  end

  def state
    render json: @user, serializer: SessionSerializer
  end

  def reset
    @user = User.find_by_email(params[:email])
    if @user
      @user.reset_password
      success_response("A reset email has been sent. Please check it for your new password.")
    else
      error_response(nil, "User not found", 404)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :school_id, :volunteer_type,
                                 :password, :password_confirmation,
                                 :image)
  end

  def update_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :school_id, :volunteer_type,
                                 :password, :current_password, :password_confirmation,
                                 :image, :remove_image)
  end

  def convert_base64_to_images
    unless params[:user][:data].blank?
      params[:user][:image] = PhotoUtils.convert_base64(params[:user][:data])
    end
    params[:user].delete(:data)
  end
end
