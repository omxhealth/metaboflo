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
    
    # only samples for animal
    get :index, :animal_id => animals(:one)
    assert_equal 2, assigns(:samples).size
    
    # only samples (fractiosn) for sample
    get :index, :sample_id => samples(:one)
    assert_equal 1, assigns(:samples).size
  end

  def test_should_get_new
    login_as :user
    
    # with animal_id
    get :new, :animal_id => animals(:one)
    assert_response :success
    
    # with sample_id
    get :new, :sample_id => samples(:one)
    assert_response :success
  end
  
  def test_should_not_get_new
    login_as :user
    
    # no animal_id or sample_id
    get :new
    assert_redirected_to samples_path
    
    # animal_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :animal_id => animals(:two)
    end
    
    # sample_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :sample_id => samples(:two)
    end
  end

  def test_should_create_sample
    login_as :user
    
    # with animal_id
    assert_difference('Sample.count') do
      post :create, :animal_id => animals(:one), :sample => { }
    end

    assert_redirected_to animal_sample_path(assigns(:parent), assigns(:sample))
    
    # with sample_id
    assert_difference('Sample.count') do
      post :create, :sample_id => samples(:one), :sample => { }
    end
    
    assert_redirected_to sample_sample_path(assigns(:parent), assigns(:sample))
  end
  
  def test_should_not_create_sample
    login_as :user
    
    # no animal_id or sample_id
    assert_no_difference('Sample.count') do
      post :create, :sample => { }
    end
    assert_redirected_to samples_path

    # invalid sample
    assert_no_difference('Sample.count') do
      post :create, :sample => { :original_amount => '24fs' }, :animal_id => animals(:one).id
    end
    
    # animal_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :animal_id => animals(:two), :sample => { }
    end
    
    # sample_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :sample_id => samples(:two), :sample => { }
    end
  end

  def test_should_show_sample
    login_as :user
    
    # no animal_id or sample_id
    get :show, :id => samples(:one)
    assert_response :success
    
    # with animal_id
    get :show, :animal_id => animals(:one), :id => samples(:one).id
    assert_response :success
    
    # with sample_id
    get :show, :sample_id => samples(:one), :id => samples(:four).id
    assert_response :success
  end
  
  def test_should_not_show_sample
    login_as :user2
    
    # animal_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :animal_id => animals(:one), :id => samples(:one).id
    end
    
    # sample_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :sample_id => samples(:one), :id => samples(:four).id
    end
  end

  def test_should_get_edit
    login_as :user
    
    # no animal_id or sample_id
    get :edit, :id => samples(:one)
    assert_response :success
    
    # with animal_id
    get :edit, :animal_id => animals(:one), :id => samples(:one).id
    assert_response :success
    
    # with sample_id
    get :edit, :sample_id => samples(:one), :id => samples(:four).id
    assert_response :success    
  end
  
  def test_should_not_get_edit
    login_as :user2
    
    # animal_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :animal_id => animals(:one), :id => samples(:one).id
    end
    
    # sample_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :sample_id => samples(:one), :id => samples(:four).id
    end

    # correct animal_id, but the sample is further down the tree (it is an aliquot)
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :animal_id => animals(:one), :id => samples(:four).id
    end
  end

  def test_should_update_sample
    login_as :user
    
    # no animal_id or sample_id
    put :update, :id => samples(:one).id, :sample => { }
    assert_redirected_to animal_sample_path(assigns(:animal), assigns(:sample))
    
    # with animal_id
    put :update, :animal_id => animals(:one), :id => samples(:one).id, :sample => { }
    assert_redirected_to animal_sample_path(assigns(:parent), assigns(:sample))
    
    # with sample_id
    put :update, :sample_id => samples(:one), :id => samples(:four).id, :sample => { }
    assert_redirected_to sample_sample_path(assigns(:parent), assigns(:sample))
  end
  
  def test_should_not_update_sample
    login_as :user2
    
    # animal_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :animal_id => animals(:one), :id => samples(:one).id, :sample => { }
    end
    
    # sample_id from other site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :sample_id => samples(:one), :id => samples(:four).id, :sample => { }
    end
  end

  def test_should_destroy_sample
    login_as :user
    
    # no animal_id or sample_id
    parent = samples(:one).parent
    assert_difference('Sample.count', -2) do
      delete :destroy, :id => samples(:one).id
    end
    
    assert_redirected_to animal_samples_path(parent)
  end
  
  def test_should_destroy_sample_animal_id
    login_as :user
    
    # with animal_id
    assert_difference('Sample.count', -2) do
      delete :destroy, :animal_id => animals(:one).id, :id => samples(:one).id
    end

    assert_redirected_to animal_samples_path(assigns(:animal))
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
    
    # no animal_id or sample_id
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :id => samples(:one).id
    end
    
    # with animal_id
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :animal_id => animals(:one).id, :id => samples(:one).id
    end
    
    # with sample_id
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :sample_id => samples(:one).id, :id => samples(:four).id
    end
  end
end
