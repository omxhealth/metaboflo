require 'test_helper'

class MedicationsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index, :test_subject_id => test_subjects(:one)
    assert_response :success
    assert_equal 2, assigns(:medications).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index, :test_subject_id => test_subjects(:one)
    assert_response :success
    assert_equal 2, assigns(:medications).size
  end
  
  def test_should_get_index_user
    login_as :user
    get :index, :test_subject_id => test_subjects(:one)
    assert_response :success
    assert_equal 2, assigns(:medications).size
  end
  
  def test_should_not_get_index
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :index, :test_subject_id => test_subjects(:two)
    end
  end

  def test_should_get_new_administrator
    login_as :admin
    get :new, :test_subject_id => test_subjects(:one)
    assert_response :success
  end
  
  def test_should_get_new_superuser
    login_as :superuser
    get :new, :test_subject_id => test_subjects(:one)
    assert_response :success
  end
  
  def test_should_get_new_user
    login_as :user
    get :new, :test_subject_id => test_subjects(:one)
    assert_response :success
  end
  
  def test_should_not_get_new
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :test_subject_id => test_subjects(:two)
    end
  end

  def test_should_create_medication_administrator
    login_as :admin
    assert_difference('Medication.count') do
      post :create, :test_subject_id => test_subjects(:one), :medication => { :drug => 'acetaminophen' }
    end

    assert_redirected_to test_subject_medication_path(assigns(:test_subject), assigns(:medication))
  end
  
  def test_should_create_medication_superuser
    login_as :superuser
    assert_difference('Medication.count') do
      post :create, :test_subject_id => test_subjects(:one), :medication => { :drug => 'acetaminophen' }
    end

    assert_redirected_to test_subject_medication_path(assigns(:test_subject), assigns(:medication))
  end
  
  def test_should_create_medication_user
    login_as :user
    assert_difference('Medication.count') do
      post :create, :test_subject_id => test_subjects(:one), :medication => { :drug => 'acetaminophen' }
    end

    assert_redirected_to test_subject_medication_path(assigns(:test_subject), assigns(:medication))
  end
  
  def test_should_not_create_medication
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :test_subject_id => test_subjects(:two), :medication => { :drug => 'acetaminophen' }
    end
  end

  def test_should_show_medication_administrator
    login_as :admin
    get :show, :test_subject_id => test_subjects(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_show_medication_superuser
    login_as :superuser
    get :show, :test_subject_id => test_subjects(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_show_medication_user
    login_as :user
    get :show, :test_subject_id => test_subjects(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_not_show_medication
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :test_subject_id => test_subjects(:two), :id => medications(:two).id
    end
  end

  def test_should_get_edit_administrator
    login_as :admin
    get :edit, :test_subject_id => test_subjects(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :test_subject_id => test_subjects(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_user
    login_as :user
    get :edit, :test_subject_id => test_subjects(:one), :id => medications(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :test_subject_id => test_subjects(:two), :id => medications(:two).id
    end
  end

  def test_should_update_medication_administrator
    login_as :admin
    put :update, :test_subject_id => test_subjects(:one), :id => medications(:one).id, :medication => { }
    assert_redirected_to test_subject_medication_path(assigns(:test_subject), assigns(:medication))
  end
  
  def test_should_update_medication_superuser
    login_as :superuser
    put :update, :test_subject_id => test_subjects(:one), :id => medications(:one).id, :medication => { }
    assert_redirected_to test_subject_medication_path(assigns(:test_subject), assigns(:medication))
  end
  
  def test_should_update_medication_user
    login_as :user
    put :update, :test_subject_id => test_subjects(:one), :id => medications(:one).id, :medication => { }
    assert_redirected_to test_subject_medication_path(assigns(:test_subject), assigns(:medication))
  end
  
  def test_should_not_update_medication
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :test_subject_id => test_subjects(:two), :id => medications(:two).id, :medication => { }
    end
  end

  def test_should_destroy_medication_administrator
    login_as :admin
    assert_difference('Medication.count', -1) do
      delete :destroy, :test_subject_id => test_subjects(:one), :id => medications(:one).id
    end

    assert_redirected_to test_subject_medications_path(assigns(:test_subject))
  end
  
  def test_should_destroy_medication_superuser
    login_as :superuser
    assert_difference('Medication.count', -1) do
      delete :destroy, :test_subject_id => test_subjects(:one), :id => medications(:one).id
    end

    assert_redirected_to test_subject_medications_path(assigns(:test_subject))
  end
  
  def test_should_destroy_medication_user
    login_as :user
    assert_difference('Medication.count', -1) do
      delete :destroy, :test_subject_id => test_subjects(:one), :id => medications(:one).id
    end

    assert_redirected_to test_subject_medications_path(assigns(:test_subject))
  end
  
  def test_should_not_destroy_medication
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :test_subject_id => test_subjects(:two), :id => medications(:two).id
    end
  end
end
