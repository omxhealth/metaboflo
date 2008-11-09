require 'test_helper'

class AdministratorsControllerTest < ActionController::TestCase
  def test_should_get_index
    [:superuser, :admin].each do |user|
      login_as user
      get :index
      assert_response :success
    end
  end
  
  def test_should_not_get_index_not_permitted
    login_as :user
    get :index
    assert_response :redirect
  end
end
