class Api::V1::Admin::SchoolsController < Api::V1::Admin::BaseController
  load_and_authorize_resource

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
