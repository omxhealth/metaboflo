require 'test_helper'

class SamplesControllerTest < ActionController::TestCase
  def test_should_get_index_admin
    # all samples for administrator
    login_as :admin
    get :index
    assert_response :success
    assert_equal 4, assigns(:samples).size
  end
  
  def test_should_get_index_superuser
    # all samples for superuser
    login_as :superuser
    get :index
    assert_response :success
    assert_equal 4, assigns(:samples).size
  end
  
  def test_should_get_index_user
    login_as :user
    
    # only samples from user's site
    get :index
    assert_response :success
    assert_equal 3, assigns(:samples).size
    
    # only samples for patient
    get :index, :patient_id => patients(:one)
    assert_equal 2, assigns(:samples).size
    
    # only samples (fractiosn) for sample
    get :index, :sample_id => samples(:one)
    assert_equal 1, assigns(:samples).size
  end

  def test_should_get_new
    login_as :user
    
    # with patient_id
    get :new, :patient_id => patients(:one)
    assert_response :success
    
    # with sample_id
    get :new, :sample_id => samples(:one)
    assert_response :success
  end
  
  def test_should_not_get_new
    login_as :user
    
    # no patient_id or sample_id
    get :new
    assert_redirected_to samples_path
    
    # patient_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :patient_id => patients(:two)
    end
    
    # sample_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :sample_id => samples(:two)
    end
  end

  def test_should_create_sample
    login_as :user
    
    # with patient_id
    assert_difference('Sample.count') do
      post :create, :patient_id => patients(:one), :sample => { }
    end

    assert_redirected_to patient_sample_path(assigns(:parent), assigns(:sample))
    
    # with sample_id
    assert_difference('Sample.count') do
      post :create, :sample_id => samples(:one), :sample => { }
    end
    
    assert_redirected_to sample_sample_path(assigns(:parent), assigns(:sample))
  end
  
  def test_should_not_create_sample
    login_as :user
    
    # no patient_id or sample_id
    assert_no_difference('Sample.count') do
      post :create, :sample => { }
    end
    assert_redirected_to samples_path
    
    # patient_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :patient_id => patients(:two), :sample => { }
    end
    
    # sample_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :sample_id => samples(:two), :sample => { }
    end
  end

  def test_should_show_sample
    login_as :user
    
    # no patient_id or sample_id
    get :show, :id => samples(:one)
    assert_response :success
    
    # with patient_id
    get :show, :patient_id => patients(:one), :id => samples(:one).id
    assert_response :success
    
    # with sample_id
    get :show, :sample_id => samples(:one), :id => samples(:four).id
    assert_response :success
  end
  
  def test_should_not_show_sample
    login_as :user2
    
    # patient_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :patient_id => patients(:one), :id => samples(:one).id
    end
    
    # sample_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :sample_id => samples(:one), :id => samples(:four).id
    end
  end

  def test_should_get_edit
    login_as :user
    
    # no patient_id or sample_id
    get :edit, :id => samples(:one)
    assert_response :success
    
    # with patient_id
    get :edit, :patient_id => patients(:one), :id => samples(:one).id
    assert_response :success
    
    # with sample_id
    get :edit, :sample_id => samples(:one), :id => samples(:four).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user2
    
    # patient_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :patient_id => patients(:one), :id => samples(:one).id
    end
    
    # sample_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :sample_id => samples(:one), :id => samples(:four).id
    end
  end

  def test_should_update_sample
    login_as :user
    
    # no patient_id or sample_id
    put :update, :id => samples(:one).id, :sample => { }
    assert_redirected_to patient_sample_path(assigns(:patient), assigns(:sample))
    
    # with patient_id
    put :update, :patient_id => patients(:one), :id => samples(:one).id, :sample => { }
    assert_redirected_to patient_sample_path(assigns(:parent), assigns(:sample))
    
    # with sample_id
    put :update, :sample_id => samples(:one), :id => samples(:four).id, :sample => { }
    assert_redirected_to sample_sample_path(assigns(:parent), assigns(:sample))
  end
  
  def test_should_not_update_sample
    login_as :user2
    
    # patient_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :patient_id => patients(:one), :id => samples(:one).id, :sample => { }
    end
    
    # sample_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :sample_id => samples(:one), :id => samples(:four).id, :sample => { }
    end
  end

  def test_should_destroy_sample
    login_as :user
    
    # no patient_id or sample_id
    assert_difference('Sample.count', -1) do
      delete :destroy, :id => samples(:one).id
    end
    
    assert_redirected_to samples_path
  end
  
  def test_should_destroy_sample_patient_id
    login_as :user
    
    # with patient_id
    assert_difference('Sample.count', -1) do
      delete :destroy, :patient_id => patients(:one).id, :id => samples(:one).id
    end

    assert_redirected_to patient_samples_path(assigns(:patient))
  end
  
  def test_should_destroy_sample_sample_id
    login_as :user
      
    # with sample_id
    assert_difference('Sample.count', -1) do
      delete :destroy, :sample_id => samples(:one).id, :id => samples(:four).id
    end

    assert_redirected_to sample_samples_path(assigns(:parent))
  end
  
  def test_should_not_destroy_sample
    login_as :user2
    
    # no patient_id or sample_id
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :id => samples(:one).id
    end
    
    # with patient_id
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :patient_id => patients(:one).id, :id => samples(:one).id
    end
    
    # with sample_id
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :sample_id => samples(:one).id, :id => samples(:four).id
    end
  end
end
