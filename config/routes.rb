Rails.application.routes.draw do
  get 'calendar/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
    }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  get 'dashboard', to: 'dashboard#index'
  get 'my_dashboard', to: 'dashboard#my_dashboard'

  resources :users, only: [:show, :index, :edit, :update]
  resources :costings

  get "calendar", to: "calendar#index", as: :calendar


  resources :households do
    resources :chores, only: [:index, :new]

    post 'invite_member', on: :member
    post 'leave', on: :collection

    member do
      get 'edit'
      patch '', action: :update
      delete 'remove_member/:user_id', to: 'households#remove_member', as: 'remove_member'
    end
  end


  resources :chores

  authenticated :user do
    root 'dashboard#home', as: :authenticated_root
  end

  unauthenticated do
    root 'pages#landing', as: :unauthenticated_root
  end
end
