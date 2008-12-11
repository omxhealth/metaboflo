require 'test_helper'

class TaskCategoriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:task_categories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_task_category
    assert_difference('TaskCategory.count') do
      post :create, :task_category => { }
    end

    assert_redirected_to task_category_path(assigns(:task_category))
  end

  def test_should_show_task_category
    get :show, :id => task_categories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => task_categories(:one).id
    assert_response :success
  end

  def test_should_update_task_category
    put :update, :id => task_categories(:one).id, :task_category => { }
    assert_redirected_to task_category_path(assigns(:task_category))
  end

  def test_should_destroy_task_category
    assert_difference('TaskCategory.count', -1) do
      delete :destroy, :id => task_categories(:one).id
    end

    assert_redirected_to task_categories_path
  end
end
