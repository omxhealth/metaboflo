require 'test_helper'

class ExperimentsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index, :sample_id => samples(:one)
    assert_response :success
    assert_equal 2, assigns(:experiments).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index, :sample_id => samples(:one)
    assert_response :success
    assert_equal 2, assigns(:experiments).size
  end
  
  def test_should_get_index_user
    login_as :user
    get :index, :sample_id => samples(:one)
    assert_response :success
    assert_equal 2, assigns(:experiments).size
    
    #No sample -> Should list all experiments
    get :index
    assert_response :success
    #assert_equal 2, assigns(:experiments).size
  end
  
  def test_should_get_new_administrator
    login_as :admin
    get :new, :sample_id => samples(:one)
    assert_response :success
  end
  
  def test_should_get_new_superuser
    login_as :superuser
    get :new, :sample_id => samples(:one)
    assert_response :success
  end
  
  def test_should_get_new_user
    login_as :user
    get :new, :sample_id => samples(:one)
    assert_response :success
  end
  
  def test_should_not_get_new
    login_as :user
    
    # no sample_id
    assert_raise ActiveRecord::RecordNotFound do
      get :new
    end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :sample_id => samples(:two)
    end
  end

  def test_should_create_experiment_administrator
    login_as :admin
    assert_difference('Experiment.count') do
      post :create, :sample_id => samples(:one), :experiment => {:name => 'test', :experiment_type_id => experiment_types(:one).id}
    end

    assert_redirected_to sample_experiment_path(samples(:one), assigns(:experiment))
  end
  
  def test_should_create_experiment_superuser
    login_as :superuser
    assert_difference('Experiment.count') do
      post :create, :sample_id => samples(:one), :experiment => {:name => 'test', :experiment_type_id => experiment_types(:one).id}
    end

    assert_redirected_to sample_experiment_path(samples(:one), assigns(:experiment))
  end
  
  def test_should_create_experiment_user
    login_as :user
    assert_difference('Experiment.count') do
      post :create, :sample_id => samples(:one), :experiment => {:name => 'test', :experiment_type_id => experiment_types(:one).id}
    end

    assert_redirected_to sample_experiment_path(samples(:one), assigns(:experiment))
  end
  
  def test_should_not_create_experiment
    login_as :user
    
    # no sample_id
    assert_raise ActiveRecord::RecordNotFound do
      post :create
    end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :sample_id => samples(:two)
    end
  end

  def test_should_show_experiment_administrator
    login_as :admin
    get :show, :sample_id => samples(:one), :id => experiments(:one).id
    assert_response :success
  end
  
  def test_should_show_experiment_superuser
    login_as :superuser
    get :show, :sample_id => samples(:one), :id => experiments(:one).id
    assert_response :success
  end
  
  def test_should_show_experiment_user
    login_as :user
    get :show, :sample_id => samples(:one), :id => experiments(:one).id
    assert_response :success
  end
  
  def test_should_not_show_experiment
    login_as :user
    
    # no sample_id
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :id => experiments(:one).id
    end
    
    # no sample_id
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :sample_id => samples(:two), :id => experiments(:two).id
    end
  end

  def test_should_get_edit_administrator
    login_as :admin
    get :edit, :sample_id => samples(:one), :id => experiments(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :sample_id => samples(:one), :id => experiments(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_user
    login_as :user
    get :edit, :sample_id => samples(:one), :id => experiments(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user
    
    # no sample_id
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :id => experiments(:one).id
    end

    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :sample_id => samples(:two), :id => experiments(:two).id
    end
  end

  def test_should_update_experiment_administrator
    login_as :admin
    put :update, :sample_id => samples(:one), :id => experiments(:one).id, :experiment => { }
    assert_redirected_to sample_experiment_path(samples(:one), assigns(:experiment))
  end
  
  def test_should_update_experiment_superuser
    login_as :superuser
    put :update, :sample_id => samples(:one), :id => experiments(:one).id, :experiment => { }
    assert_redirected_to sample_experiment_path(samples(:one), assigns(:experiment))
  end
  
  def test_should_update_experiment_user
    login_as :user
    put :update, :sample_id => samples(:one), :id => experiments(:one).id, :experiment => { }
    assert_redirected_to sample_experiment_path(samples(:one), assigns(:experiment))
  end
  
  def test_should_not_update_experiment
    login_as :user
    
    # no sample id
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :id => experiments(:one).id, :experiment => { }
    end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :sample_id => samples(:two), :id => experiments(:two).id, :experiment => { }
    end
  end

  def test_should_destroy_experiment_administrator
    login_as :admin
    assert_difference('Experiment.count', -1) do
      delete :destroy, :sample_id => samples(:one), :id => experiments(:one).id
    end

    assert_redirected_to experiments_path
  end
  
  def test_should_destroy_experiment_superuser
    login_as :superuser
    assert_difference('Experiment.count', -1) do
      delete :destroy, :sample_id => samples(:one), :id => experiments(:one).id
    end

    assert_redirected_to experiments_path
  end
  
  def test_should_destroy_experiment_user
    login_as :user
    assert_difference('Experiment.count', -1) do
      delete :destroy, :sample_id => samples(:one), :id => experiments(:one).id
    end

    assert_redirected_to experiments_path
  end
  
  def test_should_not_destroy_experiment
    login_as :user
    
    # no sample_id
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :id => experiments(:one).id
    end

    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :sample_id => samples(:two).id, :id => experiments(:two).id
    end
  end
end
