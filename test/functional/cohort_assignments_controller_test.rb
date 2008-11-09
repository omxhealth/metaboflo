require 'test_helper'

class CohortAssignmentsControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :user
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_not_nil assigns(:cohort_assignments)
  end

  def test_should_get_new
    login_as :user
    get :new, :patient_id => patients(:one)
    assert_response :success
  end

  def test_should_create_cohort_assignment
    login_as :user
    assert_difference('CohortAssignment.count') do
      post :create, :patient_id => patients(:one), :cohort_assignment => { :cohort_id => cohorts(:two) }
    end

    assert_redirected_to patient_cohort_assignment_path(assigns(:patient), assigns(:cohort_assignment))
  end

  def test_should_show_cohort_assignment
    login_as :user
    get :show, :patient_id => patients(:one), :id => cohort_assignments(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    get :edit, :patient_id => patients(:one), :id => cohort_assignments(:one).id
    assert_response :success
  end

  def test_should_update_cohort_assignment
    login_as :user
    put :update, :patient_id => patients(:one), :id => cohort_assignments(:one).id, :cohort_assignment => { }
    assert_redirected_to patient_cohort_assignment_path(assigns(:patient), assigns(:cohort_assignment))
  end

  def test_should_destroy_cohort_assignment
    login_as :user
    assert_difference('CohortAssignment.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => cohort_assignments(:one).id
    end

    assert_redirected_to patient_cohort_assignments_path(assigns(:patient))
  end
end
