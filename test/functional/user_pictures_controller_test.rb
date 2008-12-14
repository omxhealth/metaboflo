require 'test_helper'

class UserPicturesControllerTest < ActionController::TestCase
  # def test_should_get_index
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:user_pictures)
  # end

  def test_should_get_new
    login_as :user
  
    get :new, :user_id => users(:user).id
    assert_response :success
  end

  def test_should_create_user_picture
    path = "./public/images/rails.png" 
    mimetype = "image/png"
    
    login_as :user
    assert_difference('UserPicture.count') do
      post :create, :user_id => users(:user).id, :user_picture => {:uploaded_data => ActionController::TestUploadedFile.new(path, mimetype) }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  # def test_should_show_user_picture
  #   login_as :user
  #   
  #   get :show, :id => user_pictures(:one).id, :user_id => users(:user).id
  #   assert_response :success
  # end

  def test_should_get_edit
    login_as :user
  
    get :edit, :id => user_pictures(:one).id, :user_id => users(:user).id
    assert_response :success
  end

  def test_should_update_user_picture
    login_as :user
  
    put :update, :id => user_pictures(:one).id, :user_picture => { }, :user_id => users(:user).id
    assert_redirected_to user_path(assigns(:user), assigns(:user_picture))
  end

  def test_should_destroy_user_picture
    login_as :user
    
    assert_difference('UserPicture.count', -1) do
      delete :destroy, :id => user_pictures(:one).id, :user_id => users(:user).id
    end

    assert_redirected_to user_user_pictures_path(assigns(:user))
  end
end
