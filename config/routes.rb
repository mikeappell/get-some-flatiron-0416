Rails.application.routes.draw do

  root 'home#home'

  resources 'sessions', only: :create
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'registrations#new'
  post 'signup', to: 'registrations#create'
  get '/registration/:confirmation_token' => 'users#confirm_email', as: 'registration_confirmation'

  resources 'email_addresses', only: [:create, :destroy, :update] # No views needed, updated through user edit page
  resources 'organizations', only: [:new, :show, :index, :edit, :update]
  resources 'orders'
  resources 'users', only: [:show, :index, :edit, :create, :update] # Create/new is through registrations
end
