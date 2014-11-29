GDS::Application.routes.draw do
  devise_for :users
  resources :companies

  resources :research_institutes

  resources :contacts

  resources :votes

  resources :dislikes

  resources :likes

  resources :discussions

  resources :questions, only: [:create, :show, :new]
  resources :arguments, only: [:create, :show, :new]
  resources :discussions_users
  resource :visual_aids

  resources :users	
	root 'static_pages#home'
  post '/discussions/:id/leave' => 'discussions#leave'
  post '/discussions/:id/enter' => 'discussions#enter'

  post '/visual_aids/:id/open' => 'visual_aids#open'
  post '/visual_aids/:id/close' => 'visual_aids#close'
  get '/discussions/:id/arguments' => 'discussions#arguments'
  delete 'visual_aids/:id' => 'visual_aids#destroy'

  get '/user_leaved/:id' => 'discussions#user_leaved'
  get '/user_entered/:id' => 'discussions#user_entered'

  get '/discussions/:id/evaluate' => 'discussions#evaluate'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
	
end
