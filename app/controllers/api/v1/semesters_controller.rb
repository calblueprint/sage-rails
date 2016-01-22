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
end

