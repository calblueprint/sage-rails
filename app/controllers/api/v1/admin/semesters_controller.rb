class Api::V1::Admin::SemestersController < Api::V1::Admin::BaseController
  load_and_authorize_resource

  def create
    if @semester.save
      render json: @semester, serializer: SemesterSerializer
    else
      error_response(@semester)
    end
  end

  def finish
    if @semester.update_attributes(finish_params)
      render json: @semester, serializer: SemesterSerializer
    else
      error_response(@semester)
    end
  end

  private

  def semester_params
    params.require(:semester).permit(:start)
  end

  def finish_params
    params.require(:semester).permit(:finish)
  end
end
