require 'test_helper'

class Workflows::SamplesControllerTest < ActionController::TestCase
  test "should get index" do
    login_as :admin
    get :index, :code => test_subjects(:one).code, :format => :js
    assert_response :success
  end
  
  test "should get new" do
    login_as :admin
    get :new, :patient_id => test_subjects(:one).to_param, :format => :js
    assert_response :success
  end

  test "should create sample" do
    login_as :admin
    assert_difference('Sample.count') do
      post :create, :patient_id => test_subjects(:one).to_param, :format => :js
    end

    assert_response :success
  end
end
