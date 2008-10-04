require 'test_helper'

class DataFileTypesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:data_file_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_data_file_type
    assert_difference('DataFileType.count') do
      post :create, :data_file_type => { :name => 'txt' }
    end

    assert_redirected_to data_file_type_path(assigns(:data_file_type))
  end

  def test_should_show_data_file_type
    get :show, :id => data_file_types(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => data_file_types(:one).id
    assert_response :success
  end

  def test_should_update_data_file_type
    put :update, :id => data_file_types(:one).id, :data_file_type => { }
    assert_redirected_to data_file_type_path(assigns(:data_file_type))
  end

  def test_should_destroy_data_file_type
    assert_difference('DataFileType.count', -1) do
      delete :destroy, :id => data_file_types(:one).id
    end

    assert_redirected_to data_file_types_path
  end
end
