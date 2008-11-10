require 'test_helper'

class PatientsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index
    assert_response :success
    assert_equal Patient.find(:all).size, assigns(:patients).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index
    assert_response :success
    assert_equal Patient.find(:all).size, assigns(:patients).size
  end
  
  def test_should_get_index_user
    login_as :user
    get :index
    assert_response :success
    assert_equal Patient.find(:all, :conditions => ['site_id=?', sites(:one)]).size, assigns(:patients).size
  end

  def test_should_get_new
    login_as :user
    get :new
    assert_response :success
  end

  def test_should_create_patient
    login_as :user
    assert_difference('Patient.count') do
      post :create, :patient => { :code => 'TESTCODE', :site_id => sites(:one).id }
    end

    assert_redirected_to patient_path(assigns(:patient))
  end

  def test_should_show_patient_administrator
    login_as :admin
    get :show, :id => patients(:one).id
    assert_response :success
  end
  
  def test_should_show_patient_superuser
    login_as :superuser
    get :show, :id => patients(:one).id
    assert_response :success
  end
  
  def test_should_show_patient_user
    login_as :user
    get :show, :id => patients(:one).id
    assert_response :success
  end
  
  def test_should_not_get_patient
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :id => patients(:two).id
    end
  end

  def test_should_get_edit_administrator
    login_as :admin
    get :edit, :id => patients(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :id => patients(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_user
    login_as :user
    get :edit, :id => patients(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :id => patients(:two).id
    end
  end

  def test_should_update_patient_administrator
    login_as :admin
    put :update, :id => patients(:one).id, :patient => { }
    assert_redirected_to patient_path(assigns(:patient))
  end

  def test_should_update_patient_superuser
    login_as :superuser
    put :update, :id => patients(:one).id, :patient => { }
    assert_redirected_to patient_path(assigns(:patient))
  end
  
  def test_should_update_patient_user
    login_as :user
    put :update, :id => patients(:one).id, :patient => { }
    assert_redirected_to patient_path(assigns(:patient))
  end
  
  def test_should_not_update_patient
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :id => patients(:two).id, :patients => { }
    end
  end
  
  def test_should_destroy_patient_administrator
    login_as :admin
    assert_difference('Patient.count', -1) do
      delete :destroy, :id => patients(:one).id
    end
    
    assert_redirected_to patients_path
  end
  
  def test_should_destroy_patient_superuser
    login_as :superuser
    assert_difference('Patient.count', -1) do
      delete :destroy, :id => patients(:one).id
    end
    
    assert_redirected_to patients_path
  end
  
  def test_should_destroy_patient_user
    login_as :user
    assert_difference('Patient.count', -1) do
      delete :destroy, :id => patients(:one).id
    end

    assert_redirected_to patients_path
  end
  
  def test_should_not_destroy_patient
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :id => patients(:two).id
    end
  end
end
