require 'test_helper'

class CohortsControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :user
    get :index
    assert_response :success
    assert_not_nil assigns(:cohorts)
  end

  def test_should_get_new
    login_as :user
    get :new
    assert_response :success
  end

  def test_should_create_cohort
    login_as :user
    assert_difference('Cohort.count') do
      post :create, :cohort => { :name => 'abc' }
    end

    assert_redirected_to cohort_path(assigns(:cohort))
  end

  def test_should_show_cohort
    login_as :user
    get :show, :id => cohorts(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    get :edit, :id => cohorts(:one).id
    assert_response :success
  end

  def test_should_update_cohort
    login_as :user
    put :update, :id => cohorts(:one).id, :cohort => { }
    assert_redirected_to cohort_path(assigns(:cohort))
  end

  def test_should_destroy_cohort
    login_as :user
    assert_difference('Cohort.count', -1) do
      delete :destroy, :id => cohorts(:one).id
    end

    assert_redirected_to cohorts_path
  end
end
