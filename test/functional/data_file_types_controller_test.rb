require 'test_helper'

class DataFileTypesControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index
    assert_response :success
    assert_not_nil assigns(:data_file_types)
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index
    assert_response :success
    assert_not_nil assigns(:data_file_types)
  end
  
  def test_should_get_index_user
    login_as :user
    get :index
    assert_response :success
    assert_not_nil assigns(:data_file_types)
  end

  def test_should_get_new_administrator
    login_as :admin
    get :new
    assert_response :success
  end
  
  def test_should_get_new_superuser
    login_as :superuser
    get :new
    assert_response :success
  end
  
  def test_should_not_get_new_not_permitted
    login_as :user
    get :new
    assert_redirected_to data_file_types_path
  end

  def test_should_create_data_file_type_administrator
    login_as :admin
    assert_difference('DataFileType.count') do
      post :create, :data_file_type => { :name => 'txt' }
    end

    assert_redirected_to data_file_type_path(assigns(:data_file_type))
  end
  
  def test_should_create_data_file_type_superuser
    login_as :superuser
    assert_difference('DataFileType.count') do
      post :create, :data_file_type => { :name => 'txt' }
    end

    assert_redirected_to data_file_type_path(assigns(:data_file_type))
  end
  
  def test_should_not_create_data_file_type_not_permitted
    login_as :user
    assert_no_difference('DataFileType.count') do
      post :create, :data_file_type => { :name => 'txt' }
    end

    assert_redirected_to data_file_types_path
  end

  def test_should_show_data_file_type_administrator
    login_as :admin
    get :show, :id => data_file_types(:one).id
    assert_response :success
  end
  
  def test_should_show_data_file_type_superuser
    login_as :superuser
    get :show, :id => data_file_types(:one).id
    assert_response :success
  end
  
  def test_should_show_data_file_type_user
    login_as :user
    get :show, :id => data_file_types(:one).id
    assert_response :success
  end

  def test_should_get_edit_administrator
    login_as :admin
    get :edit, :id => data_file_types(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :id => data_file_types(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit_not_permitted
    login_as :user
    get :edit, :id => data_file_types(:one).id
    assert_redirected_to data_file_types_path
  end

  def test_should_update_data_file_type
    login_as :user
    put :update, :id => data_file_types(:one).id, :data_file_type => { }
    assert_redirected_to data_file_type_path(assigns(:data_file_type))
  end
  
  def test_should_update_data_file_type_administrator
    login_as :admin
    put :update, :id => data_file_types(:one).id, :data_file_type => { }
    assert_redirected_to data_file_type_path(assigns(:data_file_type))
  end
  
  def test_should_update_data_file_type_superuser
    login_as :superuser
    put :update, :id => data_file_types(:one).id, :data_file_type => { }
    assert_redirected_to data_file_type_path(assigns(:data_file_type))
  end

  def test_should_destroy_data_file_type_administrator
    login_as :admin
    assert_difference('DataFileType.count', -1) do
      delete :destroy, :id => data_file_types(:one).id
    end

    assert_redirected_to data_file_types_path
  end
  
  def test_should_not_destroy_data_file_type_superuser
    login_as :superuser
    assert_no_difference('DataFileType.count') do
      delete :destroy, :id => data_file_types(:one).id
    end

    assert_redirected_to data_file_types_path
  end
  
  def test_should_not_destroy_data_file_type_user
    login_as :user
    assert_no_difference('DataFileType.count') do
      delete :destroy, :id => data_file_types(:one).id
    end

    assert_redirected_to data_file_types_path
  end
end
