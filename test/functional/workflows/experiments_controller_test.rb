require 'test_helper'

class Workflows::ExperimentsControllerTest < ActionController::TestCase
  test "should get index" do
    login_as :admin
    get :index
    assert_response :success
  end

  test "should get new" do
    login_as :admin
    get :new, :sample_id => samples(:one).to_param
    assert_response :success
  end

  test "should create experiment" do
    login_as :admin
    assert_difference('Experiment.count') do
      post :create, :experiment => { :name => 'new experiment', :experiment_type_id => experiment_types(:one).id }, :sample_id => samples(:one).to_param
    end

    assert_redirected_to sample_experiment_path(assigns(:sample), assigns(:experiment))
  end

  test "should show experiment" do
    login_as :admin
    get :show, :id => experiments(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as :admin
    get :edit, :id => experiments(:one).to_param
    assert_response :success
  end

  test "should update experiment" do
    login_as :admin
    put :update, :id => experiments(:one).to_param, :experiment => { }
    assert_redirected_to workflows_experiment_path(assigns(:experiment))
  end

  test "should destroy experiment" do
    login_as :admin
    assert_difference('Experiment.count', -1) do
      delete :destroy, :id => experiments(:one).to_param
    end

    assert_redirected_to workflows_experiments_path
  end
end
