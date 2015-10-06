class Api::V1::CheckInsController < Api::V1::BaseController
  load_and_authorize_resource :user
  load_and_authorize_resource :check_in, through: :user

  def index
    render json: @check_ins, each_serializer: CheckInListSerializer
  end

  def show
    render json: @check_in, serializer: CheckInSerializer
  end

  def create
    if @check_in.save
      render json: @check_in, serializer: CheckInSerializer
    else
      error_response(@check_in)
    end
  end

  private

  def check_in_params
    params.require(:check_in).permit(:start, :finish, :school_id, :user_id)
  end
end
