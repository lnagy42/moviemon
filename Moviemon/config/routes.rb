Rails.application.routes.draw do
  root 'moviemon#shutdownscreen'
  get 'shutdownscreen' => 'moviemon#shutdownscreen'
  get 'titlescreen' => 'moviemon#titlescreen'
  get 'worldmap' => 'moviemon#worldmap'
  get 'moviedex' => 'moviemon#moviedex'
  get 'moviedex2' => 'moviemon#moviedex2'
  get 'battle' => 'moviemon#battle'
  get 'save' => 'moviemon#save'
  get 'loadgame'=> 'moviemon#loadgame'
  get 'victory' => 'moviemon#victory'
  get 'defeat' => 'moviemon#defeat'
  get 'coward' => 'moviemon#coward'
  get 'endofgame' => 'moviemon#endofgame'
  get 'nodata' => 'moviemon#nodata'

  # input
  get '/power' => 'moviemon#power'
  get '/up' => 'moviemon#up'
  get '/down' => 'moviemon#down'
  get '/right' => 'moviemon#right'
  get '/left' => 'moviemon#left'
  get '/select' => 'moviemon#select'
  get '/start' => 'moviemon#start'
  get '/buttonA' => 'moviemon#buttona'
  get '/buttonB' => 'moviemon#buttonb'
  #
  # root 'moviemon#power'
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
