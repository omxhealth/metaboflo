require 'test_helper'

class TestSubjectsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index
    assert_response :success
    assert_equal TestSubject.find(:all).size, assigns(:test_subjects).size
  end
  
  def test_should_get_index_superuser
    login_as :superuser
    get :index
    assert_response :success
    assert_equal TestSubject.find(:all).size, assigns(:test_subjects).size
  end
  
  def test_should_get_index_user
    login_as :user
    get :index
    assert_response :success
    assert_equal TestSubject.find(:all, :conditions => ['site_id=?', sites(:one)]).size, assigns(:test_subjects).size
  end

  def test_should_get_new
    login_as :user
    get :new
    assert_response :success
  end

  def test_should_create_test_subject
    login_as :user
    assert_difference('TestSubject.count') do
      post :create, :test_subject => { :code => 'TESTCODE', :site_id => sites(:one).id }
    end

    assert_redirected_to test_subject_path(assigns(:test_subject))
  end

  def test_should_show_test_subject_administrator
    login_as :admin
    get :show, :id => test_subjects(:one).id
    assert_response :success
  end
  
  def test_should_show_test_subject_superuser
    login_as :superuser
    get :show, :id => test_subjects(:one).id
    assert_response :success
  end
  
  def test_should_show_test_subject_user
    login_as :user
    get :show, :id => test_subjects(:one).id
    assert_response :success
  end
  
  def test_should_not_get_test_subject
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :show, :id => test_subjects(:two).id
    end
  end

  def test_should_get_edit_administrator
    login_as :admin
    get :edit, :id => test_subjects(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_superuser
    login_as :superuser
    get :edit, :id => test_subjects(:one).id
    assert_response :success
  end
  
  def test_should_get_edit_user
    login_as :user
    get :edit, :id => test_subjects(:one).id
    assert_response :success
  end
  
  def test_should_not_get_edit
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      get :edit, :id => test_subjects(:two).id
    end
  end

  def test_should_update_test_subject_administrator
    login_as :admin
    put :update, :id => test_subjects(:one).id, :test_subject => { }
    assert_redirected_to test_subject_path(assigns(:test_subject))
  end

  def test_should_update_test_subject_superuser
    login_as :superuser
    put :update, :id => test_subjects(:one).id, :test_subject => { }
    assert_redirected_to test_subject_path(assigns(:test_subject))
  end
  
  def test_should_update_test_subject_user
    login_as :user
    put :update, :id => test_subjects(:one).id, :test_subject => { }
    assert_redirected_to test_subject_path(assigns(:test_subject))
  end
  
  def test_should_not_update_test_subject
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      put :update, :id => test_subjects(:two).id, :test_subjects => { }
    end
  end
  
  def test_should_destroy_test_subject_administrator
    login_as :admin
    assert_difference('TestSubject.count', -1) do
      delete :destroy, :id => test_subjects(:one).id
    end
    
    assert_redirected_to test_subjects_path
  end
  
  def test_should_destroy_test_subject_superuser
    login_as :superuser
    assert_difference('TestSubject.count', -1) do
      delete :destroy, :id => test_subjects(:one).id
    end
    
    assert_redirected_to test_subjects_path
  end
  
  def test_should_destroy_test_subject_user
    login_as :user
    assert_difference('TestSubject.count', -1) do
      delete :destroy, :id => test_subjects(:one).id
    end

    assert_redirected_to test_subjects_path
  end
  
  def test_should_not_destroy_test_subject
    login_as :user
    
    # wrong site
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :id => test_subjects(:two).id
    end
  end
end
