require 'test_helper'

class MedicationsControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :user
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_not_nil assigns(:medications)
  end

  def test_should_get_new
    login_as :user
    get :new, :patient_id => patients(:one)
    assert_response :success
  end

  def test_should_create_medication
    login_as :user
    assert_difference('Medication.count') do
      post :create, :patient_id => patients(:one), :medication => { :drug => 'acetaminophen' }
    end

    assert_redirected_to patient_medication_path(assigns(:patient), assigns(:medication))
  end

  def test_should_show_medication
    login_as :user
    get :show, :patient_id => patients(:one), :id => medications(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    get :edit, :patient_id => patients(:one), :id => medications(:one).id
    assert_response :success
  end

  def test_should_update_medication
    login_as :user
    put :update, :patient_id => patients(:one), :id => medications(:one).id, :medication => { }
    assert_redirected_to patient_medication_path(assigns(:patient), assigns(:medication))
  end

  def test_should_destroy_medication
    login_as :user
    assert_difference('Medication.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => medications(:one).id
    end

    assert_redirected_to patient_medications_path(assigns(:patient))
  end
end
