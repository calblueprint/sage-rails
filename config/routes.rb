Rails.application.routes.draw do
  root to: "static_pages#home"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, skip: [:registrations, :passwords]

      scope module: :admin do
        resources :schools, only: [:create, :update, :destroy]
        resources :announcements, only: [:create, :update, :destroy]
        resources :semesters, only: [:create, :update, :destroy]

        resources :check_ins, only: [:update, :destroy] do
          member do
            post :verify
          end
        end
      end

      resources :schools, only: [:index, :show]
      resources :check_ins, only: [:create, :edit]
      resources :announcements, only: [:index, :show]
      resources :users, except: [:new, :edit]
      resources :semesters, only: [:index, :show]
    end
  end
end
