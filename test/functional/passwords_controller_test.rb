require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
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
    assert_redirected_to login_path
  end

  def test_should_update_password_administrator
    login_as :admin
    put :update, :id => users(:user).id, :user => { :password => 'new_password', :password_confirmation => 'new_password' }
    assert_redirected_to user_path(assigns(:user))
    assert_not_nil User.authenticate(users(:user).login, 'new_password')
  end
  
  def test_should_update_user_superuser
    login_as :superuser
    put :update, :id => users(:user).id, :user => { :password => 'new_password', :password_confirmation => 'new_password' }
    assert_redirected_to user_path(assigns(:user))
    assert_not_nil User.authenticate(users(:user).login, 'new_password')
  end
  
  def test_should_update_user_self
    login_as :user
    put :update, :id => users(:user).id, :old_password => 'monkey', :user => { :password => 'new_password', :password_confirmation => 'new_password' }
    assert_redirected_to user_path(assigns(:user))
    assert_not_nil User.authenticate(users(:user).login, 'new_password')
  end
  
  def test_should_not_update_user_not_permitted
    login_as :user2
    put :update, :id => users(:user).id, :user => { }
    assert_redirected_to login_path
  end

  def test_should_not_update_user_bad_old_password
    login_as :user
    put :update, :id => users(:user).id, :old_password => 'monkey2', :user => { :password => 'new_password', :password_confirmation => 'new_password' }
    assert_not_nil User.authenticate(users(:user).login, 'monkey')
  end
  
  def test_should_not_update_user_mismatch
    login_as :user
    put :update, :id => users(:user).id, :old_password => 'monkey', :user => { :password => 'new_password1', :password_confirmation => 'new_password2' }
    assert_not_nil User.authenticate(users(:user).login, 'monkey')
  end
end
