require 'test_helper'

class AnimalsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index
    assert_response :success
    assert_equal Animal.find(:all).size, assigns(:animals).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index
    assert_response :success
    assert_equal Animal.find(:all).size, assigns(:animals).size
  end
  
  def test_should_get_index_user
    login_as :user
    get :index
    assert_response :success
    assert_equal Animal.find(:all, :conditions => ['site_id=?', sites(:one)]).size, assigns(:animals).size
  end

  def test_should_get_new
    login_as :user
    get :new
    assert_response :success
  end

  def test_should_create_animal
    login_as :user
    assert_difference('Animal.count') do
      post :create, :animal => { :code => 'TESTCODE', :site_id => sites(:one).id }
    end

    assert_redirected_to animal_path(assigns(:animal))
  end

  def test_should_show_animal_administrator
    login_as :admin
    get :show, :id => animals(:one).id
    assert_response :success
  end
  
  def test_should_show_animal_superuser
    login_as :superuser
    get :show, :id => animals(:one).id
    assert_response :success
  end
  
  def test_should_show_animal_user
    login_as :user
    get :show, :id => animals(:one).id
    assert_response :success
  end
  
  def test_should_not_get_animal
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :id => animals(:two).id
    end
  end

  def test_should_get_edit_administrator
    login_as :admin
    get :edit, :id => animals(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :id => animals(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_user
    login_as :user
    get :edit, :id => animals(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :id => animals(:two).id
    end
  end

  def test_should_update_animal_administrator
    login_as :admin
    put :update, :id => animals(:one).id, :animal => { }
    assert_redirected_to animal_path(assigns(:animal))
  end

  def test_should_update_animal_superuser
    login_as :superuser
    put :update, :id => animals(:one).id, :animal => { }
    assert_redirected_to animal_path(assigns(:animal))
  end
  
  def test_should_update_animal_user
    login_as :user
    put :update, :id => animals(:one).id, :animal => { }
    assert_redirected_to animal_path(assigns(:animal))
  end
  
  def test_should_not_update_animal
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :id => animals(:two).id, :animals => { }
    end
  end
  
  def test_should_destroy_animal_administrator
    login_as :admin
    assert_difference('Animal.count', -1) do
      delete :destroy, :id => animals(:one).id
    end
    
    assert_redirected_to animals_path
  end
  
  def test_should_destroy_animal_superuser
    login_as :superuser
    assert_difference('Animal.count', -1) do
      delete :destroy, :id => animals(:one).id
    end
    
    assert_redirected_to animals_path
  end
  
  def test_should_destroy_animal_user
    login_as :user
    assert_difference('Animal.count', -1) do
      delete :destroy, :id => animals(:one).id
    end

    assert_redirected_to animals_path
  end
  
  def test_should_not_destroy_animal
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :id => animals(:two).id
    end
  end
end
