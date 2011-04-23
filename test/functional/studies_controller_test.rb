require 'test_helper'

class StudiesControllerTest < ActionController::TestCase

  def test_export
    login_as :user
    
    assert test_subjects(:one).features.length == 2
  end

  def test_should_get_index
    login_as :user
    
    get :index
    assert_response :success
    assert_not_nil assigns(:studies)
  end

  def test_should_get_new
    login_as :user

    get :new
    assert_response :success
    assert_not_nil assigns(:study)
  end

  def test_should_create_study
    login_as :user
    
      assert_difference('Study.count') do
        post :create, :study => { :name => 'abc' }
      end
      assert assigns(:study)
      assert assigns(:study).class.to_s == "Study"
      assert_redirected_to assigns(:study)
  end

  def test_should_show_study
    login_as :user
    get :show, :id => cohorts(:study).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    get :edit, :id => cohorts(:study).id
    assert_response :success
  end

  def test_should_update_study
    login_as :user
    
    put :update, :id => cohorts(:study).id, :study => { }
    assert_redirected_to study_path(assigns(:study))
  end

  def test_should_destroy_study
    login_as :user
    assert_difference('Study.count', -1) do
      delete :destroy, :id => cohorts(:study).id
    end

    assert_redirected_to studies_path
  end

end
