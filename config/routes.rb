Metaboflo::Application.routes.draw do
  ## Public routes
  match 'about' => 'public/pages#about'
  match 'contact' => 'public/pages#contact'
  match 'services' => 'public/pages#services'

  ## User routes
  devise_for :users do
    match 'landing' => 'bovine#index', :as => :user_root
  end

  resources :users do 
    resources :user_pictures
    resources :tasks
  end

  ## Client routes 
  devise_for :clients do
    match 'clients/home' => 'clients/home#index', :as => :client_root
  end
  
  namespace :clients do
    resources :samples, :only => [ :index, :show ]
    resources :sample_manifests do
      get 'confirm', :on => :member
      get 'print', :on => :member
      get 'download_uploaded_manifest', :on => :member
      get 'download_blank_manifest', :on => :member
      get 'download_guideline', :on => :member
    end
    resources :home, :only => [ :index ]
  end
  resources :clients

  ## API Resources
  namespace :api do
  end


  ## Resources

  # Diets/etc.
  resources :nutrients
  resources :ingredients
  resources :diets

  # Planning
  resources :task_categories
  resources :task_priorities
  resources :tasks do
    collection do
      get :gantt
      get :calendar
    end
    member do
      put :complete
    end
  end

  # Data files
  resources :data_file_types
  resources :data_files

  # Studies
  resources :studies do
    member do
      get :analysis
    end
  end

  resources :metabolites do
    collection do
      post :search
    end
  end

  resources :experiments do
    resources :data_files
    resources :grouping_assignments
  end

  # Workflows
  namespace :workflows do
    resources :experiments
    resources :patients, :only => [:index, :new, :create]
    resources :samples, :only => [:index, :show, :new, :create]
    resources :studies, :only => [:new, :create] do
      member do
        get :cohort_assignment
        post :add_to_cohort
        post :remove_from_cohort
      end
    end
  end

  # Sample/test subject tracking
  resources :samples do
    resources :samples do
      member do
        post :finish
      end
    end
    resources :experiments
    resources :grouping_assignments
    member do
      post :finish
    end
  end
  
  resources :test_subjects do
    member do
      get :tree
    end
    resources :meals
    resources :samples do
      member do
        post :finish
      end
    end
    resources :grouping_assignments
    resources :lab_tests
    resources :medications
    resources :test_subject_evaluations
    resources :experiments
  end

  # Site admin
  resources :protocols
  resources :lab_tests
  resources :sites do
    resources :users
  end

  # Grouping/cohorts
  resources :groupings do 
    resources :grouping_assignments
    resources :study_grouping_assignments
  end
  
  Grouping.valid_types.each do |grouping_type| # Add routes to direct the grouping types to the correct place
    resources "#{grouping_type.tableize.singularize}_groupings", :controller => 'groupings', :defaults => { :type => grouping_type } 
  end

  
  ## Named routes
  match 'admin' => 'administrators#index', :as => :admin

  ## Route URL 
  root :to => 'public/pages#home'
end
