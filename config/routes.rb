Rails.application.routes.draw do
  root to: "static_pages#home"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, skip: [:registrations]

      namespace :admin do
        resources :schools, only: [:create, :update, :destroy]
        resources :announcements, only: [:create, :update, :destroy]
        resources :semesters, only: [:create] do
          member do
            get :export
            post :finish
            post :pause
          end
        end

        resources :check_ins, only: [:update, :destroy] do
          member do
            post :verify
          end
        end

        resources :users, only: [:create] do
          member do
            post :verify
            post :promote
            post :status
          end
        end

        resources :user_semesters, only: [:update]
      end

      resources :schools,        only:   [:index, :show]
      resources :announcements,  only:   [:index, :show]
      resources :semesters,      only:   [:index, :show] do
        collection do
          post :join
        end
      end
      resources :check_ins,      except: [:new, :edit, :update]
      resources :users,          except: [:new, :edit] do
        member do
          get :state
          post :register
        end

        collection do
          post :reset
        end
      end
      resources :user_semesters, only:   [:index]
    end
  end
end
