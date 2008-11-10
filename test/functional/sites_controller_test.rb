require 'test_helper'

class SitesControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index
    assert_response :success
    assert_not_nil assigns(:sites)
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index
    assert_response :success
    assert_not_nil assigns(:sites)
  end
  
  def test_should_get_index_user
    login_as :user
    get :index
    assert_response :success
    assert_not_nil assigns(:sites)
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
    assert_redirected_to sites_path
  end

  def test_should_create_site_administrator
    login_as :admin
    assert_difference('Site.count') do
      post :create, :site => { :name => 'New Site' }
    end

    assert_redirected_to site_path(assigns(:site))
  end
  
  def test_should_create_site_superuser
    login_as :superuser
    assert_difference('Site.count') do
      post :create, :site => { :name => 'New Site' }
    end

    assert_redirected_to site_path(assigns(:site))
  end
  
  def test_should_not_create_site_not_permitted
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

  def test_should_get_edit_administrator
    login_as :admin
    get :edit, :id => sites(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :id => sites(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit_not_permitted
    login_as :user
    get :edit, :id => sites(:one).id
    assert_redirected_to sites_path
  end

  def test_should_update_site_administrator
    login_as :admin
    put :update, :id => sites(:one).id, :site => { }
    assert_redirected_to site_path(assigns(:site))
  end
  
  def test_should_update_site_superuser
    login_as :superuser
    put :update, :id => sites(:one).id, :site => { }
    assert_redirected_to site_path(assigns(:site))
  end
  
  def test_should_not_update_site_not_permitted
    login_as :user
    put :update, :id => sites(:one).id, :site => { }
    assert_redirected_to sites_path
  end

  def test_should_destroy_site_administrator
    login_as :admin
    assert_difference('Site.count', -1) do
      delete :destroy, :id => sites(:one).id
    end

    assert_redirected_to sites_path
  end
  
  def test_should_not_destroy_site_superuser
    login_as :superuser
    assert_no_difference('Site.count') do
      delete :destroy, :id => sites(:one).id
    end
  end
  
  def test_should_not_destroy_site_user
    login_as :user
    assert_no_difference('Site.count') do
      delete :destroy, :id => sites(:one).id
    end
  end
end
