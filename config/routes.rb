Rails.application.routes.draw do
  root to: "static_pages#home"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, skip: [:registrations, :passwords]

      resources :users, except: [:new, :edit] do
        resources :announcements, except: [:new, :edit]
      end

      resources :check_ins, except: [:new, :edit] do
        member do
          post :verify
        end
      end
    end
  end
end
