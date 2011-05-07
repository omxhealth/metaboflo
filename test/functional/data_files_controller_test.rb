require 'test_helper'

class DataFilesControllerTest < ActionController::TestCase
  
  def test_should_get_index
    login_as :user
    get :index, :experiment_id => experiments(:one).id
    assert_response :success
    assert_not_nil assigns(:data_files)
  end

  def test_should_get_new
    login_as :user
    get :new, :experiment_id => experiments(:one).id
    assert_response :success
  end

  def test_should_create_data_file
    
    path = "./public/images/rails.png" 
    mimetype = "image/png" 
    
    login_as :user
    
    assert_difference('DataFile.count') do
      post :create, :experiment_id => experiments(:one).id, :data_file => {:uploaded_data => ActionController::TestUploadedFile.new(path, mimetype), :data_file_type_id => data_file_types(:one).id }
    end

    assert_redirected_to experiment_data_file_path(experiments(:one), assigns(:data_file))
  end

  def test_should_show_data_file
    login_as :user
    get :show, :id => data_files(:one).id, :experiment_id => experiments(:one).id
    assert_response :success
  end

  # def test_should_get_edit
  #   get :edit, :id => data_files(:one).id, :experiment_id => experiments(:one).id
  #   assert_response :success
  # end
  # 
  # def test_should_update_data_file
  #   put :update, :id => data_files(:one).id, :data_file => { }, :experiment_id => experiments(:one).id
  #   assert_redirected_to data_file_path(assigns(:data_file))
  # end

  def test_should_destroy_data_file
    login_as :user
    assert_difference('DataFile.count', -1) do
      delete :destroy, :id => data_files(:one).id, :experiment_id => experiments(:one).id
    end

    assert_redirected_to experiment_data_files_path(experiments(:one))
  end
end
