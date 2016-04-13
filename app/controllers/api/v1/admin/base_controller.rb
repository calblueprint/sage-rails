class Api::V1::Admin::BaseController < Api::V1::BaseController
  before_filter :authorize_access!

  private

  def authorize_access!
    authorize! :manage, :admin_dashboard
  end
end
