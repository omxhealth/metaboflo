require 'test_helper'

class AdministratorsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator_administrator
    login_as :admin
    get :index
    assert_response :success
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index
    assert_response :success
  end
  
  def test_should_not_get_index_not_permitted
    login_as :user
    get :index
    assert_response :redirect
  end
end
