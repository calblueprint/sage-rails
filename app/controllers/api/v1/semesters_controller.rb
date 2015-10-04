class Api::V1::SemestersController < Api::V1::BaseController
  load_and_authorize_resource :user
  load_and_authorize_resource :semester, through: :user

  def index
    render @semesters, each_serializer: SemesterListSerializer
  end

  def show
    render @semester, serializer: SemesterSerializer
  end

  def create
    if @semester.save
      render @semester, serializer: SemesterSerializer
    else
      error_response(@semester)
    end
  end

  def update
    if @semester.update_attributes(semester_params)
      render @semester, serializer: SemesterSerializer
    else
      error_response(@semester)
    end
  end

  private

  def semester_params
    params.require(:semester).permit(:start, :end, :school_id)
  end
end
