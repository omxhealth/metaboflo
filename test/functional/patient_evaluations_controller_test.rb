require 'test_helper'

class AnimalEvaluationsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index, :animal_id => animals(:one)
    assert_response :success
    assert_equal 2, assigns(:animal_evaluations).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index, :animal_id => animals(:one)
    assert_response :success
    assert_equal 2, assigns(:animal_evaluations).size
  end
  
  def test_should_get_index_user
    login_as :user
    
    get :index, :animal_id => animals(:one)
    assert_response :success
    assert_equal 2, assigns(:animal_evaluations).size
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
  
  def test_should_not_get_new_user
    login_as :user
    
    # # no animal_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   get :new
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :new, :animal_id => animals(:two)
    end
  end

  def test_should_create_animal_evaluation_administrator
    login_as :admin
    assert_difference('AnimalEvaluation.count') do
      post :create, :animal_id => animals(:one)
    end

    assert_redirected_to animal_animal_evaluation_path(assigns(:animal), assigns(:animal_evaluation))
  end
  
  def test_should_create_animal_evaluation_superuser
    login_as :superuser
    assert_difference('AnimalEvaluation.count') do
      post :create, :animal_id => animals(:one)
    end

    assert_redirected_to animal_animal_evaluation_path(assigns(:animal), assigns(:animal_evaluation))
  end
  
  def test_should_create_animal_evaluation_user
    login_as :user
    assert_difference('AnimalEvaluation.count') do
      post :create, :animal_id => animals(:one)
    end

    assert_redirected_to animal_animal_evaluation_path(assigns(:animal), assigns(:animal_evaluation))
  end
  
  def test_should_not_create_animal_evaluation
    login_as :user
    
    # # no animal_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   post :create
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      post :create, :animal_id => animals(:two)
    end
  end
  
  def test_should_show_animal_evaluation_administrator
    login_as :admin
    get :show, :animal_id => animals(:one), :id => animal_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_show_animal_evaluation_superuser
    login_as :superuser
    get :show, :animal_id => animals(:one), :id => animal_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_show_animal_evaluation_user
    login_as :user
    get :show, :animal_id => animals(:one), :id => animal_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_not_show_animal_evaluation
    login_as :user
    
    # # no animal id
    # assert_raise ActiveRecord::RecordNotFound do
    #   get :show, :id => animal_evaluations(:one).id
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :animal_id => animals(:two), :id => animal_evaluations(:two).id
    end
  end

  def test_should_get_edit_admin
    login_as :admin
    get :edit, :animal_id => animals(:one), :id => animal_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :animal_id => animals(:one), :id => animal_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_user
    login_as :user
    get :edit, :animal_id => animals(:one), :id => animal_evaluations(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user
    
    # # no animal id
    # assert_raise ActiveRecord::RecordNotFound do
    #   get :edit, :id => animal_evaluations(:one).id
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :animal_id => animals(:two), :id => animal_evaluations(:two).id
    end
  end

  def test_should_update_animal_evaluation_administrator
    login_as :admin
    put :update, :animal_id => animals(:one), :id => animal_evaluations(:one).id, :animal_evaluation => { }
    assert_redirected_to animal_animal_evaluation_path(assigns(:animal), assigns(:animal_evaluation))
  end
  
  def test_should_update_animal_evaluation_superuser
    login_as :superuser
    put :update, :animal_id => animals(:one), :id => animal_evaluations(:one).id, :animal_evaluation => { }
    assert_redirected_to animal_animal_evaluation_path(assigns(:animal), assigns(:animal_evaluation))
  end
  
  def test_should_update_animal_evaluation_user
    login_as :user
    put :update, :animal_id => animals(:one), :id => animal_evaluations(:one).id, :animal_evaluation => { }
    assert_redirected_to animal_animal_evaluation_path(assigns(:animal), assigns(:animal_evaluation))
  end
  
  def test_should_not_update_animal_evaluation_user
    login_as :user
    
    # # no animal_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   put :update, :id => animal_evaluations(:one).id, :animal_evaluation => { }
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :animal_id => animals(:two), :id => animal_evaluations(:two).id, :animal_evaluation => { }
    end
  end

  def test_should_destroy_animal_evaluation_administrator
    login_as :admin
    assert_difference('AnimalEvaluation.count', -1) do
      delete :destroy, :animal_id => animals(:one), :id => animal_evaluations(:one).id
    end

    assert_redirected_to animal_animal_evaluations_path(assigns(:animal))
  end
  
  def test_should_destroy_animal_evaluation_superuser
    login_as :superuser
    assert_difference('AnimalEvaluation.count', -1) do
      delete :destroy, :animal_id => animals(:one), :id => animal_evaluations(:one).id
    end

    assert_redirected_to animal_animal_evaluations_path(assigns(:animal))
  end
  
  def test_should_destroy_animal_evaluation_user
    login_as :user
    assert_difference('AnimalEvaluation.count', -1) do
      delete :destroy, :animal_id => animals(:one), :id => animal_evaluations(:one).id
    end

    assert_redirected_to animal_animal_evaluations_path(assigns(:animal))
  end
  
  def test_should_not_destroy_animal_evaluation
    login_as :user

    # # no animal_id
    # assert_raise ActiveRecord::RecordNotFound do
    #   delete :destroy, :id => animal_evaluations(:one).id
    # end
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :animal_id => animals(:two), :id => animal_evaluations(:two).id
    end
  end
end
