require 'test_helper'

class PatientEvaluationsControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :user
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_not_nil assigns(:patient_evaluations)
  end

  def test_should_get_new
    login_as :user
    get :new, :patient_id => patients(:one)
    assert_response :success
  end

  def test_should_create_patient_evaluation
    login_as :user
    assert_difference('PatientEvaluation.count') do
      post :create, :patient_id => patients(:one)
    end

    assert_redirected_to patient_patient_evaluation_path(assigns(:patient), assigns(:patient_evaluation))
  end

  def test_should_show_patient_evaluation
    login_as :user
    get :show, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    get :edit, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    assert_response :success
  end

  def test_should_update_patient_evaluation
    login_as :user
    put :update, :patient_id => patients(:one), :id => patient_evaluations(:one).id, :patient_evaluation => { }
    assert_redirected_to patient_patient_evaluation_path(assigns(:patient), assigns(:patient_evaluation))
  end

  def test_should_destroy_patient_evaluation
    login_as :user
    assert_difference('PatientEvaluation.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => patient_evaluations(:one).id
    end

    assert_redirected_to patient_patient_evaluations_path(assigns(:patient))
  end
end
