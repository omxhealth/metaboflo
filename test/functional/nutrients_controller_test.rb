require 'test_helper'

class NutrientsControllerTest < ActionController::TestCase
  test "should get index" do
    login_as :admin
    get :index
    assert_response :success
    assert_not_nil assigns(:nutrients)
  end

  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
  end

  test "should create nutrient" do
    login_as :admin
    assert_difference('Nutrient.count') do
      post :create, :nutrient => { }
    end

    assert_redirected_to nutrient_path(assigns(:nutrient))
  end

  test "should show nutrient" do
    login_as :admin
    get :show, :id => nutrients(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as :admin
    get :edit, :id => nutrients(:one).to_param
    assert_response :success
  end

  test "should update nutrient" do
    login_as :admin
    put :update, :id => nutrients(:one).to_param, :nutrient => { }
    assert_redirected_to nutrient_path(assigns(:nutrient))
  end

  test "should destroy nutrient" do
    login_as :admin
    assert_difference('Nutrient.count', -1) do
      delete :destroy, :id => nutrients(:one).to_param
    end

    assert_redirected_to nutrients_path
  end
end
