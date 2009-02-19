require 'test_helper'

class BovineControllerTest < ActionController::TestCase
  def test_index
    login_as :user2
    get :index
    assert assigns(:experiments)
    assert assigns(:experiments).empty?
  end
  
  def test_index_with_tasks
    login_as :user
    get :index
    assert assigns(:experiments)
    assert_equal 1, assigns(:experiments).size
  end
end
