require 'test_helper'

class TaskPrioritiesControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :user
    
    get :index
    assert_response :success
    assert_not_nil assigns(:task_priorities)
  end

  def test_should_get_new
    login_as :user
    
    get :new
    assert_response :success
  end

  def test_should_create_task_priority
    login_as :user
    
    assert_difference('TaskPriority.count') do
      post :create, :task_priority => { }
    end

    assert_redirected_to task_priority_path(assigns(:task_priority))
  end

  def test_should_show_task_priority
    login_as :user
    
    get :show, :id => task_priorities(:high).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    
    get :edit, :id => task_priorities(:high).id
    assert_response :success
  end

  def test_should_update_task_priority
    login_as :user
    
    put :update, :id => task_priorities(:high).id, :task_priority => { }
    assert_redirected_to task_priority_path(assigns(:task_priority))
  end

  def test_should_destroy_task_priority
    login_as :user
    
    assert_difference('TaskPriority.count', -1) do
      delete :destroy, :id => task_priorities(:high).id
    end

    assert_redirected_to task_priorities_path
  end
end
