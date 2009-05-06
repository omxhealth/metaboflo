require 'test_helper'

class IngredientsControllerTest < ActionController::TestCase
  test "should get index" do
    login_as :admin
    get :index
    assert_response :success
    assert_not_nil assigns(:ingredients)
  end

  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
  end

  test "should create ingredient" do
    login_as :admin
    assert_difference('Ingredient.count') do
      post :create, :ingredient => { :name => 'new ingredient' }
    end

    assert_redirected_to ingredient_path(assigns(:ingredient))
  end

  test "should show ingredient" do
    login_as :admin
    get :show, :id => ingredients(:one).id
    assert_response :success
  end

  test "should get edit" do
    login_as :admin
    get :edit, :id => ingredients(:one).id
    assert_response :success
  end

  test "should update ingredient" do
    login_as :admin
    put :update, :id => ingredients(:one).id, :ingredient => { }
    assert_redirected_to ingredient_path(assigns(:ingredient))
  end

  test "should destroy ingredient" do
    login_as :admin
    assert_difference('Ingredient.count', -1) do
      delete :destroy, :id => ingredients(:one).id
    end

    assert_redirected_to ingredients_path
  end
end
