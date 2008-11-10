require 'test_helper'

class CreatininesControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_equal 2, assigns(:creatinines).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_equal 2, assigns(:creatinines).size
  end
  
  def test_should_get_index_user
    login_as :user
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_equal 2, assigns(:creatinines).size
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
  
  def test_should_not_get_new
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :patient_id => patients(:two)
    end
  end

  def test_should_create_creatinine_administrator
    login_as :admin
    assert_difference('Creatinine.count') do
      post :create, :patient_id => patients(:one), :creatinine => { :tested_at => '2007-07-07 22:23:23', :level => 100.0, :unit => 'mg/mL' }
    end

    assert_redirected_to patient_creatinine_path(assigns(:patient), assigns(:creatinine))
  end
  
  def test_should_create_creatinine_superuser
    login_as :superuser
    assert_difference('Creatinine.count') do
      post :create, :patient_id => patients(:one), :creatinine => { :tested_at => '2007-07-07 22:23:23', :level => 100.0, :unit => 'mg/mL' }
    end

    assert_redirected_to patient_creatinine_path(assigns(:patient), assigns(:creatinine))
  end
  
  def test_should_create_creatinine_user
    login_as :user
    assert_difference('Creatinine.count') do
      post :create, :patient_id => patients(:one), :creatinine => { :tested_at => '2007-07-07 22:23:23', :level => 100.0, :unit => 'mg/mL' }
    end

    assert_redirected_to patient_creatinine_path(assigns(:patient), assigns(:creatinine))
  end
  
  def test_should_not_create_creatinine
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :patient_id => patients(:two), :creatinine => { :tested_at => '2007-07-07 22:23:23', :level => 100.0, :unit => 'mg/mL' }
    end
  end

  def test_should_show_creatinine_administrator
    login_as :admin
    get :show, :patient_id => patients(:one), :id => creatinines(:one).id
    assert_response :success
  end
  
  def test_should_show_creatinine_superuser
    login_as :superuser
    get :show, :patient_id => patients(:one), :id => creatinines(:one).id
    assert_response :success
  end
  
  def test_should_show_creatinine_user
    login_as :user
    get :show, :patient_id => patients(:one), :id => creatinines(:one).id
    assert_response :success
  end
  
  def test_should_not_show_creatinine
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :patient_id => patients(:two), :id => creatinines(:two).id
    end
  end
  
  def test_should_get_edit_administrator
    login_as :admin
    get :edit, :patient_id => patients(:one), :id => creatinines(:one).id
    assert_response :success
  end

  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :patient_id => patients(:one), :id => creatinines(:one).id
    assert_response :success
  end
  
  def test_should_get_edit
    login_as :user
    get :edit, :patient_id => patients(:one), :id => creatinines(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :patient_id => patients(:two), :id => creatinines(:two).id
    end
  end

  def test_should_update_creatinine_administrator
    login_as :admin
    put :update, :patient_id => patients(:one), :id => creatinines(:one).id, :creatinine => { }
    assert_redirected_to patient_creatinine_path(assigns(:patient), assigns(:creatinine))
  end
  
  def test_should_update_creatinine_superuser
    login_as :superuser
    put :update, :patient_id => patients(:one), :id => creatinines(:one).id, :creatinine => { }
    assert_redirected_to patient_creatinine_path(assigns(:patient), assigns(:creatinine))
  end
  
  def test_should_update_creatinine_user
    login_as :user
    put :update, :patient_id => patients(:one), :id => creatinines(:one).id, :creatinine => { }
    assert_redirected_to patient_creatinine_path(assigns(:patient), assigns(:creatinine))
  end
  
  def test_should_not_update_creatinine
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :patient_id => patients(:two), :id => creatinines(:two).id, :creatinine => { }
    end
  end

  def test_should_destroy_creatinine_administrator
    login_as :admin
    assert_difference('Creatinine.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => creatinines(:one).id
    end

    assert_redirected_to patient_creatinines_path(assigns(:patient))
  end
  
  def test_should_destroy_creatinine_superuser
    login_as :superuser
    assert_difference('Creatinine.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => creatinines(:one).id
    end

    assert_redirected_to patient_creatinines_path(assigns(:patient))
  end
  
  def test_should_destroy_creatinine_user
    login_as :user
    assert_difference('Creatinine.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => creatinines(:one).id
    end

    assert_redirected_to patient_creatinines_path(assigns(:patient))
  end
  
  def test_should_not_destroy_creatinine
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :patient_id => patients(:two), :id => creatinines(:two).id
    end
  end
end
