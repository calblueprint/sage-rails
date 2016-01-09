class Api::V1::CheckInsController < Api::V1::BaseController
  load_and_authorize_resource

  # Scopes
  has_scope :school_id
  has_scope :user_id
  has_scope :semester_id
  has_scope :verified, type: :boolean, allow_blank: true
  has_scope :current_semester, type: :boolean
  has_scope :sort, using: [:attr, :order], type: :hash

  def index
    render json: apply_scopes(CheckIn).all, each_serializer: CheckInListSerializer
  end

  def show
    render json: @check_in, serializer: CheckInSerializer
  end

  def create
    if @check_in.save
      @check_in.add_time
      render json: @check_in, serializer: CheckInSerializer
    else
      error_response(@check_in)
    end
  end

  private

  def check_in_params
    params.require(:check_in).permit(:start, :finish, :school_id, :user_id, :comment, :verified)
  end
end
