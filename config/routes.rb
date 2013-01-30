Mystore::Application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"


  Spree::Core::Engine.routes.prepend do
    resources :activities, :controller => "products"
    root :to => 'home#home_page'
    ["Home", "Activities", "Contact", "About Us", "Faqs", "Partners And Operators", "Privacy Policy", "Terms And Conditions"].each do |item|
      match '/pages/:page_name' => 'home#show_pages'
    end
    namespace :admin do
      resources :activities, :controller => "products"
    end
  end

  mount Spree::Core::Engine, :at => '/'


  Spree::Core::Engine.routes.append do
    devise_for :users,
               :class_name => Spree::User,
               :skip => [:unlocks],
               :controllers => { :sessions => 'spree/user_sessions', 
               :omniauth_callbacks => "spree/omniauth_callbacks",
               :registrations => 'spree/user_registrations' }
    resources  :user_authentications
    match 'account' => 'users#show', :as => 'user_root'
    namespace :admin do
      resources :authentication_methods
    end
  end

  
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

