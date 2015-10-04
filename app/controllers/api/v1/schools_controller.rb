class Api::V1::SchoolsController < Api::V1::BaseController
  load_and_authorize_resource param_method: :school_params

  def index
    render json: @school, each_seralizer: SchoolListSerializer
  end

  def show
    render json: @school, serializer: SchoolSerializer
  end

  def create
    if @school.save
      render json: @school, serializer: SchoolSerializer
    else
      error_response(@school)
    end
  end

  def update
    if @school.update_attributes(school_params)
      render json: @school, serializer: SchoolSerializer
    else
      error_response(@school)
    end
  end

  def destroy
    if @school.destroy
      render json: @school, serializer:SchoolSerializer
    else
      error_response(@school)
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :lat, :lng)
  end
end
