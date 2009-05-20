require 'test_helper'

class MealsControllerTest < ActionController::TestCase
  test "should get index" do
    login_as :admin
    
    get :index, :animal_id => animals(:one).id
    assert_response :success
    assert_not_nil assigns(:meals)
  end

  test "should get new" do
    login_as :admin
    
    get :new, :animal_id => animals(:one).id
    assert_response :success
  end

  test "should create meal" do
    login_as :admin
    
    assert_difference('Meal.count') do
      post :create, :animal_id => animals(:one).id, :meal => { :diet_id => diets(:one).id, :amount => 45, :consumed_during_period => 1, :consumed_on_day => 3 }      
    end

    assert_redirected_to animal_path(assigns(:animal))
  end

  test "should show meal" do
    login_as :admin
    
    get :show, :animal_id => animals(:one).id, :id => meals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as :admin
    
    get :edit, :animal_id => animals(:one).id, :id => meals(:one).to_param
    assert_response :success
  end

  test "should update meal" do
    login_as :admin
    
    put :update, :animal_id => animals(:one).id, :id => meals(:one).to_param, :meal => { }
    assert_redirected_to animal_meal_path(assigns(:animal), assigns(:meal))
  end

  test "should destroy meal" do
    login_as :admin
    
    assert_difference('Meal.count', -1) do
      delete :destroy, :animal_id => animals(:one).id, :id => meals(:one).id      
    end

    assert_redirected_to animal_meals_path(assigns(:animal))
  end
end
