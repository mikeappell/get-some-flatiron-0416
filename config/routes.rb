Rails.application.routes.draw do

  root 'home#home'

  resources 'sessions', only: :create
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'registrations#new'
  post 'signup', to: 'registrations#create'
  get '/registration/:confirmation_token' => 'users#confirm_email', as: 'registration_confirmation'
  get '/email/:confirmation_token' => 'users#confirm_email', as: 'email_confirmation'

  resources 'email_addresses', only: [:create, :new, :destroy, :update] # No views needed, updated through user edit page
  resources 'organizations', only: [:new, :show, :index, :edit, :update]
  resources 'orders', only: [:new, :show, :create, :update, :destroy]
  resources 'users', only: [:show, :index, :edit, :create, :update] # Create/new is through registrations
  resources 'groups', only: [:new, :create]

  get '/:username/settings' => 'users#edit', as: 'user_settings'

  get '/:username/organizations' => 'organizations#manage_organizations', as: 'manage_organizations'
  post '/find_org_names' => 'organizations#find_org_names'
end
