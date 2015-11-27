Rails.application.routes.draw do
  root to: "static_pages#home"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, skip: [:registrations, :passwords]

      namespace :admin do
        resources :schools, only: [:create, :update, :destroy]
        resources :announcements, only: [:create, :update, :destroy]
        resources :semesters, only: [:create, :update, :destroy]

        resources :check_ins, only: [:update, :destroy] do
          member do
            post :verify
          end
        end

        resources :users, only: [:create] do
          member do
            post :promote
          end
        end
      end

      resources :schools,       only:   [:index, :show]
      resources :announcements, only:   [:index, :show]
      resources :semesters,     only:   [:index, :show]
      resources :check_ins,     except: [:new, :edit, :update]
      resources :users,         except: [:new, :edit]
    end
  end
end
