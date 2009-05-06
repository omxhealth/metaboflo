require 'test_helper'

class DietsControllerTest < ActionController::TestCase
  test "should get index" do
    login_as :admin
    get :index
    assert_response :success
    assert_not_nil assigns(:diets)
  end

  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
  end

  test "should create diet" do
    login_as :admin
    assert_difference('Diet.count') do
      post :create, :diet => { :name => 'new diet' }
    end

    assert_redirected_to diet_path(assigns(:diet))
  end

  test "should show diet" do
    login_as :admin
    get :show, :id => diets(:one).id
    assert_response :success
  end

  test "should get edit" do
    login_as :admin
    get :edit, :id => diets(:one).id
    assert_response :success
  end

  test "should update diet" do
    login_as :admin
    put :update, :id => diets(:one).id, :diet => { }
    assert_redirected_to diet_path(assigns(:diet))
  end

  test "should destroy diet" do
    login_as :admin
    assert_difference('Diet.count', -1) do
      delete :destroy, :id => diets(:one).id
    end

    assert_redirected_to diets_path
  end
end
