class Api::V1::SemestersController < Api::V1::BaseController
  load_and_authorize_resource

  def index
    render json: @semesters, each_serializer: SemesterListSerializer
  end

  def show
    render json: @semester, serializer: SemesterSerializer
  end

  def create
    if @semester.save
      render json: @semester, serializer: SemesterSerializer
    else
      error_response(@semester)
    end
  end

  def update
    if @semester.update_attributes(semester_params)
      render json: @semester, serializer: SemesterSerializer
    else
      error_response(@semester)
    end
  end

  def destroy
    if @semester.destroy
      render json: @semester, serializer: SemesterSerializer
    else
      error_response(@semester)
    end
  end

  private

  def semester_params
    params.require(:semester).permit(:start, :finish, :school_id, :user_id)
  end
end

