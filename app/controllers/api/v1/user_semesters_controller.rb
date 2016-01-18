class Api::V1::UserSemestersController < Api::V1::BaseController
  load_and_authorize_resource

  has_scope :semester_id
  has_scope :user_id

  def index
    render json: apply_scopes(UserSemester).all, each_serializer: UserSemesterListSerializer
  end
end
