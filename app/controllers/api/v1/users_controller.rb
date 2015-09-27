class Api::V1::UsersController < Api::V1::BaseController
  # If we're creating a user, we want to skip the user validations
  skip_before_filter :authenticate_user_from_token!, only: [:create]
  skip_before_filter :authenticate_api_v1_user!,     only: [:create]
  load_and_authorize_resource param_method: :user_params

  def index
    render json: @users, each_serializer: UserListSerializer
  end

  def show
    render json: @user, serializer: UserSerializer
  end

  def create
    if @user.save
      successful_login(@user)
    else
      error_response(@user)
    end
  end

  def update
    if @user.update_with_password(user_params)
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

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role,
                                 :password, :current_password, :password_confirmation)
  end
end
