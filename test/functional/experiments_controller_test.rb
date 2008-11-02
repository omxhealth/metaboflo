require 'test_helper'

class ExperimentsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index, :sample_id => samples(:one).id
    assert_response :success
    assert_not_nil assigns(:experiments)
  end

  def test_should_get_new
    get :new, :sample_id => samples(:one).id
    assert_response :success
  end

  def test_should_create_experiment
    assert_difference('Experiment.count') do
      post :create, :sample_id => samples(:one).id
    end

    assert_redirected_to experiment_path(assigns(:experiment))
  end

  def test_should_show_experiment
    get :show, :sample_id => samples(:one).id, :id => experiments(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :sample_id => samples(:one).id, :id => experiments(:one).id
    assert_response :success
  end

  def test_should_update_experiment
    put :update, :sample_id => samples(:one).id, :id => experiments(:one).id, :experiment => { }
    assert_redirected_to experiment_path(assigns(:experiment))
  end

  def test_should_destroy_experiment
    assert_difference('Experiment.count', -1) do
      delete :destroy, :id => experiments(:one).id, :sample_id => samples(:one).id
    end

    assert_redirected_to experiments_path
  end
end
