require 'test_helper'

class CohortAssignmentsControllerTest < ActionController::TestCase
  
  def setup
    super
    login_as :user
  end
  
  def test_should_get_index_from_assignable
    get :index, :animal_id => animals(:one)
    assert_response :success
    assert_not_nil assigns(:cohort_assignments)
  end

  def test_should_get_new
    get :new, :animal_id => animals(:one)
    assert_response :success
  end

  def test_should_create_cohort_assignment
    assert_difference('CohortAssignment.count') do
      post :create, :animal_id => animals(:one), :cohort_assignment => { :cohort_id => cohorts(:two) }
    end

    assert assigns(:assignable)
    assert assigns(:entity)
    assert_equal assigns(:assignable), assigns(:entity)
    assert_redirected_to animal_path(assigns(:assignable))
  end

  def test_should_destroy_cohort_assignment
    assert_difference('CohortAssignment.count', -1) do
      delete :destroy, :animal_id => animals(:one), :id => cohort_assignments(:one).id
    end

    assert assigns(:assignable)
    assert assigns(:entity)
    assert_equal assigns(:assignable), assigns(:entity)
    assert_redirected_to animal_path(assigns(:assignable))
  end
end
