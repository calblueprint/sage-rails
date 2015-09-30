class Api::V1::CheckInsController < Api::V1::BaseController
  load_and_authorize_resource param_method: :check_in_params

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

  def destroy
    if @check_in.destroy
      render json: @check_in, serializer: CheckInSerializer
    else
      error_response(@check_in)
    end
  end

  def verify
    @check_in.verify
    render json: @check_in, serializer: CheckInSerializer
  end

  private

  def check_in_params

  end
end
