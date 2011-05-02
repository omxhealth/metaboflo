require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :user
    
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  def test_should_get_new
    login_as :user
    
    get :new
    assert_response :success
  end

  def test_should_create_task
    login_as :user
    
    assert_difference('Task.count') do
      post :create, :task => { :subject => 'Test', :done_ratio => '4'}
    end

    assert_redirected_to task_path(assigns(:task))
  end

  def test_should_show_task
    login_as :user
    
    get :show, :id => tasks(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    
    get :edit, :id => tasks(:one).id
    assert_response :success
  end

  def test_should_update_task
    login_as :user
    
    put :update, :id => tasks(:one).id, :task => { }
    assert_redirected_to task_path(assigns(:task))
  end

  def test_should_destroy_task
    login_as :user
    
    assert_difference('Task.count', -1) do
      delete :destroy, :id => tasks(:one).id
    end

    assert_redirected_to tasks_path
  end
  
  test "should complete task" do
    login_as :superuser
    
    put :complete, :id => tasks(:one).id
    assert_redirected_to task_path(assigns(:task))
    
    assert_equal TaskStatus.find_by_name('Closed'), assigns(:task).status
    assert_equal 100, assigns(:task).done_ratio
  end
end
