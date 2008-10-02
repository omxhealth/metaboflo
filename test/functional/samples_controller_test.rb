require 'test_helper'

class SamplesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:samples)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_sample
    assert_difference('Sample.count') do
      post :create, :sample => { }
    end

    assert_redirected_to sample_path(assigns(:sample))
  end

  def test_should_show_sample
    get :show, :id => samples(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => samples(:one).id
    assert_response :success
  end

  def test_should_update_sample
    put :update, :id => samples(:one).id, :sample => { }
    assert_redirected_to sample_path(assigns(:sample))
  end

  def test_should_destroy_sample
    assert_difference('Sample.count', -1) do
      delete :destroy, :id => samples(:one).id
    end

    assert_redirected_to samples_path
  end
end
