class Api::V1::SemestersController < Api::V1::BaseController
  load_and_authorize_resource

  has_scope :current_semester, type: :boolean
  has_scope :sort, using: [:attr, :order], type: :hash
  has_scope :user_id

  def index
    render json: apply_scopes(Semester).all, each_serializer: SemesterListSerializer
  end

  def show
    render json: @semester, serializer: SemesterSerializer
  end

  def join
    if Semester.has_current_semester?
      if Semester.add_to_current_semester(current_user)
        render json: current_user, serializer: SessionSerializer
      else
        error_response(nil, "Something went wrong - please try again.")
      end
    else
      error_response(nil, "No semester currently in session.")
    end
  end
end

