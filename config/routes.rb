Rails.application.routes.draw do

  ## Public routes
  get 'about' => 'public/pages#about'
  get 'contact' => 'public/pages#contact'
  get 'services' => 'public/pages#services'

  ## Client routes
  devise_for :clients

  namespace :clients do
    resources :samples, only: [:index, :show]
    resources :sample_manifests do
      get :print, on: :member
    end
    resources :home, only: [:index]
    root 'home#index'
  end

  ## User routes
  devise_for :users

  namespace :workflows do
    resources :experiments
    resources :patients, only: [:index, :new, :create] do
      resources :samples, only: [:new, :create]
    end
    resources :samples, only: [:index, :show]
    resources :studies, only: [:new, :create] do
      member do
        get :cohort_assignment
        post :add_to_cohort
        post :remove_from_cohort
      end
    end
  end

  resources :clients

  resources :users do
    resources :user_pictures
    resources :tasks
  end

  namespace :batches do
    resources :batches, only: [:new, :create] do
      get :unprepped, on: :collection
    end

    resources :preparations, only: [:new, :create] do
      get :non_ph, on: :collection
    end

    resources :phs, only: [:edit, :update] do
      get :no_experiment, on: :collection
    end
  end

  resources :nutrients
  resources :metabolites do
    post :search, on: :collection
  end

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
    get :analysis, on: :member
  end

  resources :metabolites do
    post :search, on: :collection
  end

  resources :experiments do
    resources :data_files
    resources :grouping_assignments
  end

  # Workflows
  namespace :workflows do
    resources :experiments
    resources :patients, only: [:index, :new, :create]
    resources :samples, only: [:index, :show, :new, :create]
    resources :studies, only: [:new, :create] do
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
      post :finish, on: :member
    end
    resources :experiments
    resources :grouping_assignments
    post :finish, on: :member
  end

  resources :test_subjects do
    get :tree, on: :member
    resources :meals
    resources :samples do
      post :finish, on: :member
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

  # Add routes to direct the grouping types to the correct place
  Grouping.valid_types.each do |grouping_type|
    resources "#{grouping_type.tableize.singularize}_groupings",
      controller: 'groupings', defaults: { type: grouping_type }
  end

  root 'samples#index'
end
