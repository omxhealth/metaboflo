require 'test_helper'

class LabTestsControllerTest < ActionController::TestCase
  def test_should_get_index_administrator
    login_as :admin
    get :index, :test_subject_id => test_subjects(:one)
    assert_response :success
    assert_equal 2, assigns(:lab_tests).size
  end

  def test_should_get_new_administrator
    login_as :admin
    get :new, :test_subject_id => test_subjects(:one)
    assert_response :success
  end

  def test_should_create_lab_test_administrator
    login_as :admin
    assert_difference('LabTest.count') do
      post :create, :test_subject_id => test_subjects(:one)
    end

    assert_redirected_to test_subject_lab_test_path(assigns(:test_subject), assigns(:lab_test))
  end

  def test_should_show_lab_test_administrator
    login_as :admin
    get :show, :test_subject_id => test_subjects(:one), :id => lab_tests(:one).id
    assert_response :success
  end

  def test_should_get_edit_admin
    login_as :admin
    get :edit, :test_subject_id => test_subjects(:one), :id => lab_tests(:one).id
    assert_response :success
  end

  def test_should_update_lab_test_administrator
    login_as :admin
    put :update, :test_subject_id => test_subjects(:one), :id => lab_tests(:one).id, :lab_test => { }
    assert_redirected_to test_subject_lab_test_path(assigns(:lab_test))
  end

  def test_should_destroy_lab_test_administrator
    login_as :admin
    assert_difference('LabTest.count', -1) do
      delete :destroy, :test_subject_id => test_subjects(:one), :id => lab_tests(:one).id
    end

    assert_redirected_to test_subject_lab_tests_path(assigns(:test_subject))
  end
end
