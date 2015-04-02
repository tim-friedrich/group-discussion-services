GDS::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :companies, only: [:new, :create, :edit, :update, :destroy]
  resources :research_institutes, only: [:new, :create, :edit, :update, :destroy]
  resources :votes, only: [:create]
  resources :dislikes, only: [:create]
  resources :likes, only: [:create]
  resources :discussions, except: [:index]
  resources :questions, only: [:create]
  resources :arguments, only: [:create]
  resources :discussions_users
  resource :visual_aids, only: [:create]
  resources :discussion_state, only: [:update]
  resources :evaluations, only: [:show]

  get '/users/new' => redirect('/users/sign_up')
  devise_for :users, :controllers => { :invitations => 'users_invitations', :registrations => "registrations" }
  resources :users, only: [:create, :show, :update, :destroy]

  get '/profile' => 'dashboard#show'
  get '/discussions' => redirect('/profile')
  root 'static_pages#home'

  get '/imprint' => 'static_pages#imprint'
  get '/contact_us' => 'static_pages#contact_us'

  get '/survey' => 'surveys#new'
  post '/survey' => 'surveys#create'
  get '/survey/result' => 'surveys#show', as: 'survey_result'

  post '/contact_us/send_mail' => 'static_pages#send_contact_mail'

  post '/discussions/:id/leave' => 'discussions#leave'
  post '/discussions/:id/enter' => 'discussions#enter'
  post '/discussions_users/:id/confirm' => 'discussions_users#confirm'

  post '/visual_aids/:id/open' => 'visual_aids#open'
  post '/visual_aids/:id/command' => 'visual_aids#command'
  post '/visual_aids/:id/close' => 'visual_aids#close'
  get '/discussions/:id/arguments' => 'discussions#arguments'
  delete 'visual_aids/:id' => 'visual_aids#destroy'

  get '/user_leaved/:id' => 'discussions#user_leaved'
  get '/user_entered/:id' => 'discussions#user_entered'
end
