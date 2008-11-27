require 'test_helper'

class ProtocolsControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :user
    
    get :index
    assert_response :success
    assert_not_nil assigns(:protocols)
  end

  def test_should_get_new
    login_as :user
    
    get :new
    assert_response :success
  end

  def test_should_create_protocol
    login_as :user
    
    assert_difference('Protocol.count') do
      post :create, :protocol => { :name => 'TEST', :uploaded_data => ActionController::TestUploadedFile.new("./public/images/rails.png", "image/png") }
    end

    assert_redirected_to protocol_path(assigns(:protocol))
  end

  def test_should_show_protocol
    login_as :user
    
    get :show, :id => protocols(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    
    get :edit, :id => protocols(:one).id
    assert_response :success
  end

  def test_should_update_protocol
    login_as :user
    
    put :update, :id => protocols(:one).id, :protocol => { }
    assert_redirected_to protocol_path(assigns(:protocol))
  end

  def test_should_destroy_protocol
    login_as :user
    
    assert_difference('Protocol.count', -1) do
      delete :destroy, :id => protocols(:one).id
    end

    assert_redirected_to protocols_path
  end
end
