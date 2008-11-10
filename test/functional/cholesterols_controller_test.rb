require 'test_helper'

class CholesterolsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_equal 2, assigns(:cholesterols).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_equal 2, assigns(:cholesterols).size
  end
  
  def test_should_get_index_user
    login_as :user
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_equal 2, assigns(:cholesterols).size
  end
  
  def test_should_not_get_index
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :index, :patient_id => patients(:two)
    end
  end

  def test_should_get_new_administrator
    login_as :admin
    get :new, :patient_id => patients(:one)
    assert_response :success
  end
  
  def test_should_get_new_superuser
    login_as :superuser
    get :new, :patient_id => patients(:one)
    assert_response :success
  end
  
  def test_should_get_new_user
    login_as :user
    get :new, :patient_id => patients(:one)
    assert_response :success
  end
  
  def test_should_not_get_new_user
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :patient_id => patients(:two)
    end
  end

  def test_should_create_cholesterol_administrator
    login_as :admin
    assert_difference('Cholesterol.count') do
      post :create, :patient_id => patients(:one), :cholesterol => { :tested_at => '2007-07-07 22:23:23', :level => 100.0, :unit => 'mg/mL' }
    end

    assert_redirected_to patient_cholesterol_path(assigns(:patient), assigns(:cholesterol))
  end
  
  def test_should_create_cholesterol_superuser
    login_as :superuser
    assert_difference('Cholesterol.count') do
      post :create, :patient_id => patients(:one), :cholesterol => { :tested_at => '2007-07-07 22:23:23', :level => 100.0, :unit => 'mg/mL' }
    end

    assert_redirected_to patient_cholesterol_path(assigns(:patient), assigns(:cholesterol))
  end
  
  def test_should_create_cholesterol_user
    login_as :user
    assert_difference('Cholesterol.count') do
      post :create, :patient_id => patients(:one), :cholesterol => { :tested_at => '2007-07-07 22:23:23', :level => 100.0, :unit => 'mg/mL' }
    end

    assert_redirected_to patient_cholesterol_path(assigns(:patient), assigns(:cholesterol))
  end
  
  def test_should_not_create_cholesterol
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :patient_id => patients(:two), :cholesterol => { :tested_at => '2007-07-07 22:23:23', :level => 100.0, :unit => 'mg/mL' }
    end
  end

  def test_should_show_cholesterol_administrator
    login_as :admin
    get :show, :patient_id => patients(:one), :id => cholesterols(:one).id
    assert_response :success
  end
  
  def test_should_show_cholesterol_superuser
    login_as :superuser
    get :show, :patient_id => patients(:one), :id => cholesterols(:one).id
    assert_response :success
  end
  
  def test_should_show_cholesterol_user
    login_as :user
    get :show, :patient_id => patients(:one), :id => cholesterols(:one).id
    assert_response :success
  end
  
  def test_should_not_show_cholesterol
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :patient_id => patients(:two), :id => cholesterols(:two).id
    end
  end

  def test_should_get_edit_administrator
    login_as :admin
    get :edit, :patient_id => patients(:one), :id => cholesterols(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :patient_id => patients(:one), :id => cholesterols(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_user
    login_as :user
    get :edit, :patient_id => patients(:one), :id => cholesterols(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :patient_id => patients(:two), :id => cholesterols(:two).id
    end
  end

  def test_should_update_cholesterol_administrator
    login_as :admin
    put :update, :patient_id => patients(:one), :id => cholesterols(:one).id, :cholesterol => { }
    assert_redirected_to patient_cholesterol_path(assigns(:patient), assigns(:cholesterol))
  end
  
  def test_should_update_cholesterol_superuser
    login_as :superuser
    put :update, :patient_id => patients(:one), :id => cholesterols(:one).id, :cholesterol => { }
    assert_redirected_to patient_cholesterol_path(assigns(:patient), assigns(:cholesterol))
  end
  
  def test_should_update_cholesterol_user
    login_as :user
    put :update, :patient_id => patients(:one), :id => cholesterols(:one).id, :cholesterol => { }
    assert_redirected_to patient_cholesterol_path(assigns(:patient), assigns(:cholesterol))
  end
  
  def test_should_not_update_cholesterol
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :patient_id => patients(:two), :id => cholesterols(:two).id, :cholesterol => { }
    end
  end
  
  def test_should_destroy_cholesterol_administrator
    login_as :admin
    assert_difference('Cholesterol.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => cholesterols(:one).id
    end

    assert_redirected_to patient_cholesterols_path(assigns(:patient))
  end
  
  def test_should_destroy_cholesterol_superuser
    login_as :superuser
    assert_difference('Cholesterol.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => cholesterols(:one).id
    end

    assert_redirected_to patient_cholesterols_path(assigns(:patient))
  end
  
  def test_should_destroy_cholesterol_user
    login_as :user
    assert_difference('Cholesterol.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => cholesterols(:one).id
    end

    assert_redirected_to patient_cholesterols_path(assigns(:patient))
  end
  
  def test_should_not_destroy_cholesterol
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :patient_id => patients(:two), :id => cholesterols(:two).id
    end
  end
end
