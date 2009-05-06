require 'test_helper'

class MetabolitesControllerTest < ActionController::TestCase
  test "should get index" do
    login_as :admin
    get :index
    assert_response :success
    assert_not_nil assigns(:metabolites)
  end

  test "should get new" do
    login_as :admin
    get :new
    assert_response :success
  end

  test "should create metabolite" do
    login_as :admin
    assert_difference('Metabolite.count') do
      post :create, :metabolite => { }
    end

    assert_redirected_to metabolite_path(assigns(:metabolite))
  end

  test "should show metabolite" do
    login_as :admin
    get :show, :id => metabolites(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as :admin
    get :edit, :id => metabolites(:one).to_param
    assert_response :success
  end

  test "should update metabolite" do
    login_as :admin
    put :update, :id => metabolites(:one).to_param, :metabolite => { }
    assert_redirected_to metabolite_path(assigns(:metabolite))
  end

  test "should destroy metabolite" do
    login_as :admin
    assert_difference('Metabolite.count', -1) do
      delete :destroy, :id => metabolites(:one).to_param
    end

    assert_redirected_to metabolites_path
  end
end
