require 'test_helper'

class SamplesControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :user
    get :index
    assert_response :success
    assert_not_nil assigns(:samples)
  end

  def test_should_get_new
    login_as :user
    get :new, :patient_id => patients(:one)
    assert_response :success
  end

  def test_should_create_sample
    login_as :user
    assert_difference('Sample.count') do
      post :create, :patient_id => patients(:one).id, :sample => { }
    end

    assert_redirected_to patient_sample_path(assigns(:patient), assigns(:sample))
  end

  def test_should_show_sample
    login_as :user
    get :show, :patient_id => patients(:one).id, :id => samples(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    get :edit, :patient_id => patients(:one).id, :id => samples(:one).id
    assert_response :success
  end

  def test_should_update_sample
    login_as :user
    put :update, :patient_id => patients(:one).id, :id => samples(:one).id, :sample => { }
    assert_redirected_to patient_sample_path(assigns(:patient), assigns(:sample))
  end

  def test_should_destroy_sample
    login_as :user
    assert_difference('Sample.count', -1) do
      delete :destroy, :patient_id => patients(:one).id, :id => samples(:one).id
    end

    assert_redirected_to patient_samples_path(assigns(:patient))
  end
end
