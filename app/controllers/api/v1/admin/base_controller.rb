class Api::V1::Admin::BaseController < Api::V1::BaseController
  # before_filter :authorize_access!

  private

  def authorize_access!
    authorize! :manage, :sage
  end
end
