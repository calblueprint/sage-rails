class Api::V1::Admin::BaseController < Api::V1::BaseController

  private

  def current_ability
    @current_ability ||= ::AdminAbility.new(current_user)
  end
end
