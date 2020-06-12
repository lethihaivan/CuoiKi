Rails.application.routes.draw do
   # post "reports/new" 
   get '/search' => 'users#search', :as => 'search_user'
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
  
    match "requests/approve_agree/:id" , :to => 'requests#approve_agree', :as => 'approve_agree', :via => :post
    match "requests/approve_disagree/:id ", :to => 'requests#approve_disagree', :as => 'approve_disagree', :via => :post
    match 'users/:id/adduser', :to => 'users#adduser', :as => 'add_user', :via => :post
    match '/users/:id/ban', :to => 'users#ban', :as => 'remove_user_department', :via => :post
   # namespace :reports do
  #resources :users , only: [:index, :new, :create, :show]
  resources :reports   #, only: [:new,:create, :destroy]
#end
  resources :requests 
 resources :departments
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
