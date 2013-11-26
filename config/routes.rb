Metaboflo::Application.routes.draw do
  devise_for :clients do
    match 'clients/home' => 'clients/home#index', :as => :client_root
  end
  
  namespace :clients do
    resources :samples, :only => [ :index, :show ]
    resources :sample_manifests do
      get 'print', :on => :member
    end
    resources :home, :only => [ :index ]
  end
  
  resources :clients

  namespace :workflows do
    resources :experiments
    resources :patients, :only => [:index, :new, :create] do
      resources :samples, :only => [:new, :create]
    end
    resources :samples, :only => [:index, :show]
    resources :studies, :only => [:new, :create] do
      member do
        get :cohort_assignment
        post :add_to_cohort
        post :remove_from_cohort
      end
    end
  end

  namespace :batches do
    resources :batches, :only => [:new, :create]
  end
  
  devise_for :users
  resources :nutrients
  resources :metabolites do
    collection do
      post :search
    end
  end

  resources :ingredients
  resources :diets
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

  resources :protocols
  resources :lab_tests
  resources :studies do
    member do
      get :analysis
    end
  end

  # Add routes to direct the grouping types to the correct place
  Grouping.valid_types.each do |grouping_type|
    resources "#{grouping_type.tableize.singularize}_groupings", :controller => 'groupings', :defaults => { :type => grouping_type } 
  end

  resources :sites do
    resources :users
  end
  
  match 'admin' => 'administrators#index', :as => :admin

  resources :users do 
    resources :user_pictures
    resources :tasks
  end
  
  resources :data_file_types
  resources :data_files
  resources :experiments do
    resources :data_files
    resources :grouping_assignments
  end

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
  
  resources :groupings do 
    resources :grouping_assignments
    resources :study_grouping_assignments
  end
  
  #match '/' => 'bovine#index'
  root :to => 'bovine#index'
end
