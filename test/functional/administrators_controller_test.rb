require 'test_helper'

class AdministratorsControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :user
    get :index
    assert_response :success
  end
end
