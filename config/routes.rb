Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'messages/create', to: 'messages#create', as: 'messages'

  root 'home#home'

  resources 'sessions', only: :create
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'registrations#new'
  post 'signup', to: 'registrations#create'
  get '/registration/:confirmation_token' => 'users#confirm_email', as: 'registration_confirmation'
  get '/email/:confirmation_token' => 'users#confirm_email', as: 'email_confirmation'
  get '/email_address/:confirmation_token' => 'email_addresses#confirm_email', as: 'email_address_confirmation'

  resources 'email_addresses', only: [:create, :new, :destroy, :update] # No views needed, updated through user edit page
  resources 'organizations', only: [:new, :show, :index, :edit, :update]
  resources 'orders', only: [:new, :show, :create, :update, :destroy]
  resources 'users', only: [:show, :index, :edit, :create, :update] # Create/new is through registrations

  post '/items', to: 'items#create'

  resources 'groups', only: [:new, :create, :update]

  get '/:username/settings' => 'users#edit', as: 'user_settings'

  get '/:username/organizations' => 'organizations#manage_organizations', as: 'manage_organizations'
  post '/find_org_names' => 'organizations#find_org_names'
  patch '/groups/:id/toggle' => 'groups#handle_toggle'

  mount ActionCable.server => '/cable'
end
