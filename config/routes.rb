Rails.application.routes.draw do
  root to: "static_pages#home"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, skip: [:registrations, :passwords]
      resources :schools, except: [:new, :edit]
      resources :users, except: [:new, :edit]
    end
  end
end
