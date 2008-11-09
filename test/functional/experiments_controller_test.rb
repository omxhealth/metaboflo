require 'test_helper'

class ExperimentsControllerTest < ActionController::TestCase
  def test_should_get_index
    login_as :user
    get :index, :sample_id => samples(:one).id
    assert_response :success
    assert_not_nil assigns(:experiments)
  end

  def test_should_get_new
    login_as :user
    get :new, :sample_id => samples(:one).id
    assert_response :success
  end

  def test_should_create_experiment
    login_as :user
    assert_difference('Experiment.count') do
      post :create, :sample_id => samples(:one).id
    end

    assert_redirected_to experiment_path(assigns(:experiment))
  end

  def test_should_show_experiment
    login_as :user
    get :show, :sample_id => samples(:one).id, :id => experiments(:one).id
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    get :edit, :sample_id => samples(:one).id, :id => experiments(:one).id
    assert_response :success
  end

  def test_should_update_experiment
    login_as :user
    put :update, :sample_id => samples(:one).id, :id => experiments(:one).id, :experiment => { }
    assert_redirected_to experiment_path(assigns(:experiment))
  end

  def test_should_destroy_experiment
    login_as :user
    assert_difference('Experiment.count', -1) do
      delete :destroy, :id => experiments(:one).id, :sample_id => samples(:one).id
    end

    assert_redirected_to experiments_path
  end
end
