class Api::V1::President::UsersController < Api::V1::President::BaseController
  load_and_authorize_resource

  def promote
    if @user.promote_president(current_user)
      render json: @user, serializer: UserSerializer
    else
      error_response(nil, "You don't have authorization to do this")
    end
  end
end
