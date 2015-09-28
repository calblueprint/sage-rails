Rails.application.routes.draw do
  root to: "static_pages#home"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, skip: [:registrations, :passwords]

      resources :users, except: [:new, :edit]
      # Future API routes here
    end
  end
end
