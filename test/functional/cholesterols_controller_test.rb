require 'test_helper'

class CholesterolsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index, :patient_id => patients(:one)
    assert_response :success
    assert_not_nil assigns(:cholesterols)
  end

  def test_should_get_new
    get :new, :patient_id => patients(:one)
    assert_response :success
  end

  def test_should_create_cholesterol
    assert_difference('Cholesterol.count') do
      post :create, :patient_id => patients(:one), :cholesterol => { :tested_at => '2007-07-07 22:23:23', :level => 100.0, :unit => 'mg/mL' }
    end

    assert_redirected_to patient_cholesterol_path(assigns(:patient), assigns(:cholesterol))
  end

  def test_should_show_cholesterol
    get :show, :patient_id => patients(:one), :id => cholesterols(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :patient_id => patients(:one), :id => cholesterols(:one).id
    assert_response :success
  end

  def test_should_update_cholesterol
    put :update, :patient_id => patients(:one), :id => cholesterols(:one).id, :cholesterol => { }
    assert_redirected_to patient_cholesterol_path(assigns(:patient), assigns(:cholesterol))
  end

  def test_should_destroy_cholesterol
    assert_difference('Cholesterol.count', -1) do
      delete :destroy, :patient_id => patients(:one), :id => cholesterols(:one).id
    end

    assert_redirected_to patient_cholesterols_path(assigns(:patient))
  end
end
