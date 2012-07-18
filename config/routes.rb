NewConfApp::Application.routes.draw do
  #resources :dmconfs
  
  match 'files/editlistener' => 'files#edit_listener', :via => :get  
  match 'files/updatelistener' => 'files#update_listener', :via => :post
  match 'files/home' => 'files#home', :via => :get
  #match 'files/cm' => 'files#cm', :via => :get
  
  match '/files/editcmhome' => 'files#edit_cm_home', :via => :get
  match '/files/startcmlistener' => 'files#start_cm_listener', :via => :get

  
  match 'files/databasemanagement' => 'files#database_management', :via => :get
  match 'files/edittypicalstreamdevelopment' => 'files#edit_typical_stream_development', :via => :get
  match 'files/updatetypicalstreamdevelopment' => 'files#update_typical_stream_development', :via => :post
  match '/files/displaydatabases' => 'files#display_databases', :via => :get
  match '/files/upgradedatabase' => 'files#upgrade_database', :via => :post
  
  match '/files/healthcheck' => 'files#show_health_check', :via => :get
  match '/files/dohealthcheck' => 'files#do_health_check', :via => :post
  
  match '/files/editconnectiondetails' => 'files#edit_connection_details', :via => :get
  match '/files/updateconnectiondetails' => 'files#update_connection_details', :via => :post
  
  #match '/files/tomcat' => 'files#tomcat', :via => :get
  match '/files/edittomcathome' => 'files#edit_tomcat_home', :via => :get
  match '/files/starttomcatlistener' => 'files#start_tomcat_listener', :via => :get
  
  #match '/files/alm' => 'files#alm', :via => :get
  match '/files/editalmsinglesignon' => 'files#edit_alm_single_sign_on', :via => :get
  match '/files/editalmhome' => 'files#edit_alm_home', :via => :get
  
  
  
  
  #match 'dmconfs/editlistener' => 'dmconfs#edit_listener', :via => :get  
  #match 'dmconfs/updatelistener' => 'dmconfs#update_listener', :via => :post
  #match 'dmconfs/home' => 'dmconfs#home', :via => :get  
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
