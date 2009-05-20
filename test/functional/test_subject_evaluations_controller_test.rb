require 'test_helper'

class TestSubjectEvaluationsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index, :test_subject_id => test_subjects(:one)
    assert_response :success
    assert_equal 2, assigns(:test_subject_evaluations).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index, :test_subject_id => test_subjects(:one)
    assert_response :success
    assert_equal 2, assigns(:test_subject_evaluations).size
  end
  
  def test_should_get_index_user
    login_as :user
    
    get :index, :test_subject_id => test_subjects(:one)
    assert_response :success
    assert_equal 2, assigns(:test_subject_evaluations).size
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
  
  def test_should_not_get_new_user
    login_as :user
    
    # # no test_subject_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   get :new
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :test_subject_id => test_subjects(:two)
    end
  end

  def test_should_create_test_subject_evaluation_administrator
    login_as :admin
    assert_difference('TestSubjectEvaluation.count') do
      post :create, :test_subject_id => test_subjects(:one)
    end

    assert_redirected_to test_subject_test_subject_evaluation_path(assigns(:test_subject), assigns(:test_subject_evaluation))
  end
  
  def test_should_create_test_subject_evaluation_superuser
    login_as :superuser
    assert_difference('TestSubjectEvaluation.count') do
      post :create, :test_subject_id => test_subjects(:one)
    end

    assert_redirected_to test_subject_test_subject_evaluation_path(assigns(:test_subject), assigns(:test_subject_evaluation))
  end
  
  def test_should_create_test_subject_evaluation_user
    login_as :user
    assert_difference('TestSubjectEvaluation.count') do
      post :create, :test_subject_id => test_subjects(:one)
    end

    assert_redirected_to test_subject_test_subject_evaluation_path(assigns(:test_subject), assigns(:test_subject_evaluation))
  end
  
  def test_should_not_create_test_subject_evaluation
    login_as :user
    
    # # no test_subject_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   post :create
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :test_subject_id => test_subjects(:two)
    end
  end
  
  def test_should_show_test_subject_evaluation_administrator
    login_as :admin
    get :show, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_show_test_subject_evaluation_superuser
    login_as :superuser
    get :show, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_show_test_subject_evaluation_user
    login_as :user
    get :show, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_not_show_test_subject_evaluation
    login_as :user
    
    # # no test_subject id
    # assert_raise ActiveRecord::RecordNotFound do
    #   get :show, :id => test_subject_evaluations(:one).id
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :test_subject_id => test_subjects(:two), :id => test_subject_evaluations(:two).id
    end
  end

  def test_should_get_edit_admin
    login_as :admin
    get :edit, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_user
    login_as :user
    get :edit, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user
    
    # # no test_subject id
    # assert_raise ActiveRecord::RecordNotFound do
    #   get :edit, :id => test_subject_evaluations(:one).id
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :test_subject_id => test_subjects(:two), :id => test_subject_evaluations(:two).id
    end
  end

  def test_should_update_test_subject_evaluation_administrator
    login_as :admin
    put :update, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id, :test_subject_evaluation => { }
    assert_redirected_to test_subject_test_subject_evaluation_path(assigns(:test_subject), assigns(:test_subject_evaluation))
  end
  
  def test_should_update_test_subject_evaluation_superuser
    login_as :superuser
    put :update, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id, :test_subject_evaluation => { }
    assert_redirected_to test_subject_test_subject_evaluation_path(assigns(:test_subject), assigns(:test_subject_evaluation))
  end
  
  def test_should_update_test_subject_evaluation_user
    login_as :user
    put :update, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id, :test_subject_evaluation => { }
    assert_redirected_to test_subject_test_subject_evaluation_path(assigns(:test_subject), assigns(:test_subject_evaluation))
  end
  
  def test_should_not_update_test_subject_evaluation_user
    login_as :user
    
    # # no test_subject_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   put :update, :id => test_subject_evaluations(:one).id, :test_subject_evaluation => { }
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :test_subject_id => test_subjects(:two), :id => test_subject_evaluations(:two).id, :test_subject_evaluation => { }
    end
  end

  def test_should_destroy_test_subject_evaluation_administrator
    login_as :admin
    assert_difference('TestSubjectEvaluation.count', -1) do
      delete :destroy, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id
    end

    assert_redirected_to test_subject_test_subject_evaluations_path(assigns(:test_subject))
  end
  
  def test_should_destroy_test_subject_evaluation_superuser
    login_as :superuser
    assert_difference('TestSubjectEvaluation.count', -1) do
      delete :destroy, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id
    end

    assert_redirected_to test_subject_test_subject_evaluations_path(assigns(:test_subject))
  end
  
  def test_should_destroy_test_subject_evaluation_user
    login_as :user
    assert_difference('TestSubjectEvaluation.count', -1) do
      delete :destroy, :test_subject_id => test_subjects(:one), :id => test_subject_evaluations(:one).id
    end

    assert_redirected_to test_subject_test_subject_evaluations_path(assigns(:test_subject))
  end
  
  def test_should_not_destroy_test_subject_evaluation
    login_as :user

    # # no test_subject_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   delete :destroy, :id => test_subject_evaluations(:one).id
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :test_subject_id => test_subjects(:two), :id => test_subject_evaluations(:two).id
    end
  end
end
