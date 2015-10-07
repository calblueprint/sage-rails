class Api::V1::SchoolsController < Api::V1::BaseController
  load_and_authorize_resource

  def index
    render json: @school, each_seralizer: SchoolListSerializer
  end

  def show
    render json: @school, serializer: SchoolSerializer
  end
end
