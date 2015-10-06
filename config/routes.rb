Rails.application.routes.draw do
  root to: "static_pages#home"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, skip: [:registrations, :passwords]

      resources :users, except: [:new, :edit] do
        resources :semesters, except: [:new, :edit]
        resources :check_ins, except: [:new, :edit] do
          member do
            post :verify
          end
        end
      end

      resources :announcements, except: [:new, :edit]
    end
  end
end
