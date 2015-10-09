class Api::V1::SemestersController < Api::V1::BaseController
  load_and_authorize_resource

  # Scopes
  has_scope :by_period, type: :hash, using: [:year, :season]

  def index
    render json: apply_scopes(Semesters).all, each_serializer: SemesterListSerializer
  end

  def show
    render json: @semester, serializer: SemesterSerializer
  end
end

