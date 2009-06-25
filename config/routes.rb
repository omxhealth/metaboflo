ActionController::Routing::Routes.draw do |map|
  map.resources :nutrients

  map.resources :metabolites, :collection => { :search => :post }

  map.resources :ingredients

  map.resources :diets

  map.resources :task_categories

  map.resources :task_priorities

  map.resources :tasks, :collection => { :gantt => :get, :calendar => :get }

  map.resources :protocols

  map.resources :lab_tests

  map.resources :sites, :has_many => [ :users ]

  map.admin 'admin', :controller => 'administrators', :action => 'index'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  
  map.resources :users, :has_many => [ :user_pictures, :tasks ]

  map.resource :session

  # map.resources :test_subject_evaluations

  #  map.resources :medications

  map.resources :data_file_types

  map.resources :data_files

  map.resources :experiments, :has_many => [ :data_files, :cohort_assignments ]
  
  map.resources :samples, :has_many => [ :samples, :experiments, :cohort_assignments ]

  map.resources :test_subjects, :has_many => [ :meals, :samples, :cohort_assignments, :lab_tests, :medications, :test_subject_evaluations ]

  map.resources :cohorts, :has_many => [ :cohort_assignments ]
  
  map.resources :passwords, :methods => [ :edit, :update ]
  
  # Add routes to direct the cohort types to the correct place
  Cohort.valid_types.each do |cohort_type|
    map.resources "#{cohort_type.tableize.singularize}_cohorts", :controller => 'cohorts', :requirements => { :type => cohort_type } 
  end


  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => 'bovine'

  # See how all your routes lay out with "rake routes"
  
  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
