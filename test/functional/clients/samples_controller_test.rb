require 'test_helper'

class Clients::SamplesControllerTest < ActionController::TestCase
  setup do
    sign_in clients(:one)
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert assigns(:samples)
  end

  test "should get show" do
    get :show, :id => clients(:one).samples.first.to_param
    assert_response :success
  end

end
