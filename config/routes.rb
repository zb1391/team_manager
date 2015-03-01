TeamManager::Application.routes.draw do  resources :tournaments
  resources :payment_notifications
  resources :organizations
  resources :summer_camps
  resources :summer_campers
  resources :locations
  resources :home_page_files
  resources :hotels
  resources :tryouts
  resources :coupons
  resources :display_tournaments
  resources :sessions, :only => [:new, :create, :destroy]
  resources :coaches
  resources :teams do
    get :password
    post :update_password
    get :events
  end


  resources :home_page_panels
  post "home_page_panels/panel_order"
  
  resources :events do
    get :email
    post :reschedule
    get :tournaments, on: :collection
  end

  resources :players  
  resources :event_imports
  root 'page#home'

  get "page/clinics"
  get "page/court_rentals"
  get "page/parties"
  get "page/camps"
  get "page/leagues"
  get "page/gym_ratz_about"
  get "page/contact"
  get "page/thank_you"
  get "page/summer_camper_registration"
  get "page/page_unavailable"
  get "page/tournament_manager"
  get "page/photo_gallery"
  get "page/rosters"
  get "page/admin_search"
  get "page/admin_home"
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
