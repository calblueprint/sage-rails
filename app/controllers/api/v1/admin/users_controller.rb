class Api::V1::UsersController < Api::V1::BaseController
  load_and_authorize_resource

  def inactive
  end
end
