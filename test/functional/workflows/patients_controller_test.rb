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
      post :create, :test_subject => { :code => 'NEW007', :site_id => users(:user).site_id, :samples_attributes => { 0 => { barcode: '235643'} } }
    end
    
    assert_equal 1, assigns(:test_subject).samples.count
    assert_redirected_to new_workflows_experiment_path
  end
end
