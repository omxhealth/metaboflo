require 'test_helper'

class Workflows::PatientsControllerTest < ActionController::TestCase
  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
  end
  
  test "should create patient" do
    login_as :user
    assert_difference('TestSubject.count') do
      post :create, :test_subject => { :code => 'NEW007', :site_id => users(:user).site_id }
    end

    assert assigns(:test_subject)
    assert_equal 1, assigns(:test_subject).samples.size
    sample_id = assigns(:test_subject).samples.first.to_param
    
    assert_redirected_to new_workflows_sample_experiment_path(assigns(:test_subject).samples.first.to_param)
  end
  
end
