class Api::V1::SemestersController < Api::V1::BaseController
  load_and_authorize_resource

  has_scope :current_semester, type: :boolean

  def index
    render json: apply_scopes(Semester).all, each_serializer: SemesterListSerializer
  end

  def show
    render json: @semester, serializer: SemesterSerializer
  end
end

