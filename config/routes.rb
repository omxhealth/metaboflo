Metaboflo::Application.routes.draw do
  namespace :workflows do
    resources :experiments
    resources :patients, :only => [:index, :new, :create] do
      resources :samples, :only => [:new, :create]
    end
    resources :samples, :only => [:index, :show]
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

  # Add routes to direct the cohort types to the correct place
  Cohort.valid_types.each do |cohort_type|
    resources "#{cohort_type.tableize.singularize}_cohorts", :controller => 'cohorts', :defaults => { :type => cohort_type } 
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
    resources :cohort_assignments
  end

  resources :samples do
    resources :samples
    resources :experiments
    resources :cohort_assignments
  end
  
  resources :test_subjects do 
    resources :meals
    resources :samples
    resources :cohort_assignments
    resources :lab_tests
    resources :medications
    resources :test_subject_evaluations
  end
  
  resources :cohorts do 
    resources :cohort_assignments
    resources :study_cohort_assignments
  end
  
  #match '/' => 'bovine#index'
  root :to => 'bovine#index'
end
