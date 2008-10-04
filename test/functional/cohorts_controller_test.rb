require 'test_helper'

class CohortsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:cohorts)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_cohort
    assert_difference('Cohort.count') do
      post :create, :cohort => { :name => 'abc' }
    end

    assert_redirected_to cohort_path(assigns(:cohort))
  end

  def test_should_show_cohort
    get :show, :id => cohorts(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => cohorts(:one).id
    assert_response :success
  end

  def test_should_update_cohort
    put :update, :id => cohorts(:one).id, :cohort => { }
    assert_redirected_to cohort_path(assigns(:cohort))
  end

  def test_should_destroy_cohort
    assert_difference('Cohort.count', -1) do
      delete :destroy, :id => cohorts(:one).id
    end

    assert_redirected_to cohorts_path
  end
end
