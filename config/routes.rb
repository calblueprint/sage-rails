Rails.application.routes.draw do
  devise_for :users
  root to: "static_pages#home"

  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      # Future API routes here
    end
  end
end
