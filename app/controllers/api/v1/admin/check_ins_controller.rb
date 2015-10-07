class Api::V1::Admin::CheckInsController < Api::V1::Admin::BaseController
  load_and_authorize_resource

  def update
    if @check_in.update_attributes(check_in_params)
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
    params.require(:check_in).permit(:start, :finish, :school_id, :comment)
  end
end
