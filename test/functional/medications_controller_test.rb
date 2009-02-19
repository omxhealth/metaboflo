require 'test_helper'

class MedicationsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index, :animal_id => animals(:one)
    assert_response :success
    assert_equal 2, assigns(:medications).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index, :animal_id => animals(:one)
    assert_response :success
    assert_equal 2, assigns(:medications).size
  end
  
  def test_should_get_index_user
    login_as :user
    get :index, :animal_id => animals(:one)
    assert_response :success
    assert_equal 2, assigns(:medications).size
  end
  
  def test_should_not_get_index
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :index, :animal_id => animals(:two)
    end
  end

  def test_should_get_new_administrator
    login_as :admin
    get :new, :animal_id => animals(:one)
    assert_response :success
  end
  
  def test_should_get_new_superuser
    login_as :superuser
    get :new, :animal_id => animals(:one)
    assert_response :success
  end
  
  def test_should_get_new_user
    login_as :user
    get :new, :animal_id => animals(:one)
    assert_response :success
  end
  
  def test_should_not_get_new
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :animal_id => animals(:two)
    end
  end

  def test_should_create_medication_administrator
    login_as :admin
    assert_difference('Medication.count') do
      post :create, :animal_id => animals(:one), :medication => { :drug => 'acetaminophen' }
    end

    assert_redirected_to animal_medication_path(assigns(:animal), assigns(:medication))
  end
  
  def test_should_create_medication_superuser
    login_as :superuser
    assert_difference('Medication.count') do
      post :create, :animal_id => animals(:one), :medication => { :drug => 'acetaminophen' }
    end

    assert_redirected_to animal_medication_path(assigns(:animal), assigns(:medication))
  end
  
  def test_should_create_medication_user
    login_as :user
    assert_difference('Medication.count') do
      post :create, :animal_id => animals(:one), :medication => { :drug => 'acetaminophen' }
    end

    assert_redirected_to animal_medication_path(assigns(:animal), assigns(:medication))
  end
  
  def test_should_not_create_medication
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :animal_id => animals(:two), :medication => { :drug => 'acetaminophen' }
    end
  end

  def test_should_show_medication_administrator
    login_as :admin
    get :show, :animal_id => animals(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_show_medication_superuser
    login_as :superuser
    get :show, :animal_id => animals(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_show_medication_user
    login_as :user
    get :show, :animal_id => animals(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_not_show_medication
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :animal_id => animals(:two), :id => medications(:two).id
    end
  end

  def test_should_get_edit_administrator
    login_as :admin
    get :edit, :animal_id => animals(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :animal_id => animals(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_user
    login_as :user
    get :edit, :animal_id => animals(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :animal_id => animals(:two), :id => medications(:two).id
    end
  end

  def test_should_update_medication_administrator
    login_as :admin
    put :update, :animal_id => animals(:one), :id => medications(:one).id, :medication => { }
    assert_redirected_to animal_medication_path(assigns(:animal), assigns(:medication))
  end
  
  def test_should_update_medication_superuser
    login_as :superuser
    put :update, :animal_id => animals(:one), :id => medications(:one).id, :medication => { }
    assert_redirected_to animal_medication_path(assigns(:animal), assigns(:medication))
  end
  
  def test_should_update_medication_user
    login_as :user
    put :update, :animal_id => animals(:one), :id => medications(:one).id, :medication => { }
    assert_redirected_to animal_medication_path(assigns(:animal), assigns(:medication))
  end
  
  def test_should_not_update_medication
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :animal_id => animals(:two), :id => medications(:two).id, :medication => { }
    end
  end

  def test_should_destroy_medication_administrator
    login_as :admin
    assert_difference('Medication.count', -1) do
      delete :destroy, :animal_id => animals(:one), :id => medications(:one).id
    end

    assert_redirected_to animal_medications_path(assigns(:animal))
  end
  
  def test_should_destroy_medication_superuser
    login_as :superuser
    assert_difference('Medication.count', -1) do
      delete :destroy, :animal_id => animals(:one), :id => medications(:one).id
    end

    assert_redirected_to animal_medications_path(assigns(:animal))
  end
  
  def test_should_destroy_medication_user
    login_as :user
    assert_difference('Medication.count', -1) do
      delete :destroy, :animal_id => animals(:one), :id => medications(:one).id
    end

    assert_redirected_to animal_medications_path(assigns(:animal))
  end
  
  def test_should_not_destroy_medication
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :animal_id => animals(:two), :id => medications(:two).id
    end
  end
end
