require File.dirname(__FILE__) + '/../test_helper'
require 'users_controller'

# Re-raise errors caught by the controller.
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
    assert_equal User.count, assigns(:users).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
    assert_equal User.count, assigns(:users).size
  end
  
  def test_should_get_index_user
    login_as :user
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
    assert_equal User.find(:all, :conditions => ['site_id=?', sites(:one).id]).size, assigns(:users).size
  end

  def test_should_get_new_administrator
    login_as :admin
    get :new
    assert_response :success
  end
  
  def test_should_get_new_superuser
    login_as :superuser
    get :new
    assert_response :success
  end
  
  def test_should_not_get_new_not_permitted
    login_as :user
    get :new
    assert_redirected_to root_path
  end

  def test_should_create_user_administrator
    login_as :admin
    assert_difference('User.count') do
      post :create, :user => { :email => 'new@example.com', :password => 'password', :password_confirmation => 'password', :site_id => sites(:one) }
    end

    assert_redirected_to user_path(assigns(:user))
  end
  
  def test_should_create_user_superuser
    login_as :superuser
    assert_difference('User.count') do
      post :create, :user => { :login => 'new_user', :email => 'new@example.com', :password => 'password', :password_confirmation => 'password', :site_id => sites(:one) }
    end

    assert_redirected_to user_path(assigns(:user))
  end
  
  def test_should_not_create_user_not_permitted
    login_as :user
    assert_no_difference('User.count') do
      post :create, :user => { :email => 'new@example.com', :password => 'password', :password_confirmation => 'password', :site_id => sites(:one) }
    end

    assert_redirected_to root_path
  end

  def test_should_show_user
    login_as :user
    get :show, :id => users(:admin).id
    assert_response :success
  end

  def test_should_get_edit_administrator
    login_as :admin
    get :edit, :id => users(:user).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :id => users(:user).id
    assert_response :success
  end
  
  def test_should_get_edit_self
    login_as :user
    get :edit, :id => users(:user).id
    assert_response :success
  end
  
  def test_should_not_get_edit_not_permitted
    login_as :user2
    get :edit, :id => users(:user).id
    assert_redirected_to root_path
  end

  def test_should_update_user_administrator
    login_as :admin
    put :update, :id => users(:user).id, :user => { }
    assert_redirected_to user_path(assigns(:user))
  end
  
  def test_should_update_user_superuser
    login_as :superuser
    put :update, :id => users(:user).id, :user => { }
    assert_redirected_to user_path(assigns(:user))
  end
  
  def test_should_update_user_self
    login_as :user
    put :update, :id => users(:user).id, :user => { }
    assert_redirected_to user_path(assigns(:user))
  end
  
  def test_should_not_update_user_not_permitted
    login_as :user2
    put :update, :id => users(:user).id, :user => { }
    assert_redirected_to root_path
  end

  def test_should_destroy_user_administrator
    login_as :admin
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:user).id
    end

    assert_redirected_to users_path
  end
  
  test "ensure can't delete own account from superuser" do
    login_as :superuser
    assert_no_difference('User.count') do
      delete :destroy, :id => users(:admin).id
    end
  end

  test "ensure can't delete own account from user" do
    login_as :user
    assert_no_difference('User.count') do
      delete :destroy, :id => users(:admin).id
    end
  end
  
  test "ensure can't delete own account from admin" do
    login_as :admin
    assert_no_difference('User.count') do
      delete :destroy, :id => users(:admin).id
    end
  end
  
  test "allow creation of user from superuser account" do
    login_as :superuser
    assert_difference 'User.count' do
      create_user
      assert_response :redirect
    end
  end
  
  test "allow creation of user from admin account" do
    login_as :admin
    assert_difference 'User.count' do
      create_user
      assert_response :redirect
    end
  end

  test "don't allow creation of user from user account" do
    login_as :user
    assert_no_difference 'User.count' do
      create_user
      assert_response :redirect
    end
  end

  protected
    def create_user(options = {})
      post :create, :user => { :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
