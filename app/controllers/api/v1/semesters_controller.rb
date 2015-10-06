class Api::V1::SemestersController < Api::V1::BaseController
  load_and_authorize_resource

  def index
    render json: @semesters, each_serializer: SemesterListSerializer
  end

  def show
    render json: @semester, serializer: SemesterSerializer
  end
end

