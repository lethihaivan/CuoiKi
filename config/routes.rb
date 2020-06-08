Rails.application.routes.draw do
   # post "reports/new" 
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  root 'static_pages#home'
  get '/sign_up' , to: 'users#new'
  get '/login', to: "sessions#new"
      post  '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
   # namespace :reports do
  #resources :users , only: [:index, :new, :create, :show]
  resources :reports, only: [:create, :destroy]
#end
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
