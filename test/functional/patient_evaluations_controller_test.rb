require 'test_helper'

class PatientEvaluationsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_equal 2, assigns(:patient_evaluations).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_equal 2, assigns(:patient_evaluations).size
  end
  
  def test_should_get_index_user
    login_as :user
    
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_equal 2, assigns(:patient_evaluations).size
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
    
    # # no patient_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   get :new
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :patient_id => patients(:two)
    end
  end

  def test_should_create_patient_evaluation_administrator
    login_as :admin
    assert_difference('PatientEvaluation.count') do
      post :create, :patient_id => patients(:one)
    end

    assert_redirected_to patient_patient_evaluation_path(assigns(:patient), assigns(:patient_evaluation))
  end
  
  def test_should_create_patient_evaluation_superuser
    login_as :superuser
    assert_difference('PatientEvaluation.count') do
      post :create, :patient_id => patients(:one)
    end

    assert_redirected_to patient_patient_evaluation_path(assigns(:patient), assigns(:patient_evaluation))
  end
  
  def test_should_create_patient_evaluation_user
    login_as :user
    assert_difference('PatientEvaluation.count') do
      post :create, :patient_id => patients(:one)
    end

    assert_redirected_to patient_patient_evaluation_path(assigns(:patient), assigns(:patient_evaluation))
  end
  
  def test_should_not_create_patient_evaluation
    login_as :user
    
    # # no patient_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   post :create
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :patient_id => patients(:two)
    end
  end
  
  def test_should_show_patient_evaluation_administrator
    login_as :admin
    get :show, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_show_patient_evaluation_superuser
    login_as :superuser
    get :show, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_show_patient_evaluation_user
    login_as :user
    get :show, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_not_show_patient_evaluation
    login_as :user
    
    # # no patient id
    # assert_raise ActiveRecord::RecordNotFound do
    #   get :show, :id => patient_evaluations(:one).id
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :patient_id => patients(:two), :id => patient_evaluations(:two).id
    end
  end

  def test_should_get_edit_admin
    login_as :admin
    get :edit, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_user
    login_as :user
    get :edit, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user
    
    # # no patient id
    # assert_raise ActiveRecord::RecordNotFound do
    #   get :edit, :id => patient_evaluations(:one).id
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :patient_id => patients(:two), :id => patient_evaluations(:two).id
    end
  end

  def test_should_update_patient_evaluation_administrator
    login_as :admin
    put :update, :patient_id => patients(:one), :id => patient_evaluations(:one).id, :patient_evaluation => { }
    assert_redirected_to patient_patient_evaluation_path(assigns(:patient), assigns(:patient_evaluation))
  end
  
  def test_should_update_patient_evaluation_superuser
    login_as :superuser
    put :update, :patient_id => patients(:one), :id => patient_evaluations(:one).id, :patient_evaluation => { }
    assert_redirected_to patient_patient_evaluation_path(assigns(:patient), assigns(:patient_evaluation))
  end
  
  def test_should_update_patient_evaluation_user
    login_as :user
    put :update, :patient_id => patients(:one), :id => patient_evaluations(:one).id, :patient_evaluation => { }
    assert_redirected_to patient_patient_evaluation_path(assigns(:patient), assigns(:patient_evaluation))
  end
  
  def test_should_not_update_patient_evaluation_user
    login_as :user
    
    # # no patient_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   put :update, :id => patient_evaluations(:one).id, :patient_evaluation => { }
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :patient_id => patients(:two), :id => patient_evaluations(:two).id, :patient_evaluation => { }
    end
  end

  def test_should_destroy_patient_evaluation_administrator
    login_as :admin
    assert_difference('PatientEvaluation.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    end

    assert_redirected_to patient_patient_evaluations_path(assigns(:patient))
  end
  
  def test_should_destroy_patient_evaluation_superuser
    login_as :superuser
    assert_difference('PatientEvaluation.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    end

    assert_redirected_to patient_patient_evaluations_path(assigns(:patient))
  end
  
  def test_should_destroy_patient_evaluation_user
    login_as :user
    assert_difference('PatientEvaluation.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    end

    assert_redirected_to patient_patient_evaluations_path(assigns(:patient))
  end
  
  def test_should_not_destroy_patient_evaluation
    login_as :user

    # # no patient_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   delete :destroy, :id => patient_evaluations(:one).id
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :patient_id => patients(:two), :id => patient_evaluations(:two).id
    end
  end
end
