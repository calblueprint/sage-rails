class Api::V1::SchoolsController < Api::V1::BaseController
  skip_before_filter :authenticate_user_from_token!, only: [:index]
  skip_before_filter :authenticate_api_v1_user!,     only: [:index]
  load_and_authorize_resource

  has_scope :sort, using: [:attr, :order], type: :hash

  def index
    serializer = current_user ? SchoolListSerializer :
                                SchoolNameSerializer

    render json: apply_scopes(School).all, each_serializer: serializer
  end

  def show
    render json: @school, serializer: SchoolSerializer
  end
end
