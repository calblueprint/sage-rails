Rails.application.routes.draw do
  root to: "static_pages#home"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, skip: [:registrations, :passwords]

      scope module: :admin do
        resources :schools, only: [:create, :update, :destroy] do
          resources :check_ins, only: [:update, :destroy] do
            member do
              post :verify
            end
          end
        end

        resources :announcements, only: [:create, :update, :destroy]
        resources :semesters, only: [:create, :update, :destroy]
      end

      resources :schools, only: [:index, :show] do
        resources :users, only: [:index, :show] do
          resources :check_ins, except: [:new, :edit]
        end
      end

      resources :announcements, only: [:index, :show]
      resources :users, except: [:new, :edit]
      resources :semesters, only: [:index, :show]
    end
  end
end
