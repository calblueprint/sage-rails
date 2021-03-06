class Api::V1::Admin::SchoolsController < Api::V1::Admin::BaseController
  prepend_before_filter :establish_director, only: [:create, :update]
  load_and_authorize_resource

  def create
    if @school.save
      @school.set_director(@director)
      render json: @school, serializer: SchoolSerializer
    else
      error_response(@school)
    end
  end

  def update
    if @school.update_attributes(school_params)
      @school.director = @director
      render json: @school, serializer: SchoolSerializer
    else
      error_response(@school)
    end
  end

  def destroy
    if @school.destroy
      render json: @school, serializer: SchoolSerializer
    else
      error_response(@school)
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :lat, :lng, :address, :radius)
  end

  def establish_director
    director_id = params[:school].delete(:director_id)
    @director = User.admin
                    .director_id([nil, params[:id]])
                    .find_by(id: director_id)
  end
end
