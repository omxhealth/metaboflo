require 'test_helper'

class LabTestsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index, :animal_id => animals(:one)
    assert_response :success
    assert_equal 2, assigns(:lab_tests).size
  end

  def test_should_get_new_administrator
    login_as :admin
    get :new, :animal_id => animals(:one)
    assert_response :success
  end

  def test_should_create_lab_test_administrator
    login_as :admin
    assert_difference('LabTest.count') do
      post :create, :animal_id => animals(:one)
    end

    assert_redirected_to animal_lab_test_path(assigns(:animal), assigns(:lab_test))
  end

  def test_should_show_lab_test_administrator
    login_as :admin
    get :show, :animal_id => animals(:one), :id => lab_tests(:one).id
    assert_response :success
  end

  def test_should_get_edit_admin
    login_as :admin
    get :edit, :animal_id => animals(:one), :id => lab_tests(:one).id
    assert_response :success
  end

  def test_should_update_lab_test_administrator
    login_as :admin
    put :update, :animal_id => animals(:one), :id => lab_tests(:one).id, :lab_test => { }
    assert_redirected_to animal_lab_test_path(assigns(:lab_test))
  end

  def test_should_destroy_lab_test_administrator
    login_as :admin
    assert_difference('LabTest.count', -1) do
      delete :destroy, :animal_id => animals(:one), :id => lab_tests(:one).id
    end

    assert_redirected_to animal_lab_tests_path(assigns(:animal))
  end
end
