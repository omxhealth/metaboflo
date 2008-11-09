require 'test_helper'

class SitesControllerTest < ActionController::TestCase
  def test_should_get_index
    [:user, :superuser, :admin].each do |user|
      login_as user
      get :index
      assert_response :success
      assert_not_nil assigns(:sites)
    end
  end

  def test_should_get_new
    [:superuser, :admin].each do |user|
      login_as user
      get :new
      assert_response :success
    end
  end
  
  def test_should_not_get_new_user
    login_as :user
    get :new
    assert_redirected_to sites_path
  end

  def test_should_create_site_superuser
    login_as :superuser
    assert_difference('Site.count') do
      post :create, :site => { :name => 'New Site' }
    end

    assert_redirected_to site_path(assigns(:site))
  end
  
  def test_should_create_site_admin
    login_as :admin
    assert_difference('Site.count') do
      post :create, :site => { :name => 'New Site' }
    end

    assert_redirected_to site_path(assigns(:site))
  end
  
  def test_should_not_create_site_user
    login_as :user
    assert_no_difference('Site.count') do
      post :create, :site => { :name => 'New Site' }
    end

    assert_redirected_to sites_path
  end

  def test_should_show_site
    login_as :user
    get :show, :id => sites(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    get :edit, :id => sites(:one).id
    assert_response :success
  end

  def test_should_update_site
    [:superuser, :admin].each do |user|
      login_as user
      put :update, :id => sites(:one).id, :site => { }
      assert_redirected_to site_path(assigns(:site))
    end
  end
  
  def test_should_not_update_site_user
    login_as :user
    put :update, :id => sites(:one).id, :site => { }
    assert_redirected_to sites_path
  end

  def test_should_destroy_site
    login_as :admin
    assert_difference('Site.count', -1) do
      delete :destroy, :id => sites(:one).id
    end

    assert_redirected_to sites_path
  end
  
  def test_should_not_destroy_site_not_admin
    [:superuser, :user].each do |user|
      login_as user
      assert_no_difference('Site.count') do
        delete :destroy, :id => sites(:one).id
      end
    end
  end
end
