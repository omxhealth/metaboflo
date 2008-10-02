require 'test_helper'

class DataFilesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:data_files)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_data_file
    assert_difference('DataFile.count') do
      post :create, :data_file => { }
    end

    assert_redirected_to data_file_path(assigns(:data_file))
  end

  def test_should_show_data_file
    get :show, :id => data_files(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => data_files(:one).id
    assert_response :success
  end

  def test_should_update_data_file
    put :update, :id => data_files(:one).id, :data_file => { }
    assert_redirected_to data_file_path(assigns(:data_file))
  end

  def test_should_destroy_data_file
    assert_difference('DataFile.count', -1) do
      delete :destroy, :id => data_files(:one).id
    end

    assert_redirected_to data_files_path
  end
end
