require 'test_helper'

class GroupingsControllerTest < ActionController::TestCase

  ValidTypes = Grouping.valid_types
  
  def test_should_get_index
    login_as :user
    
    ValidTypes.each do |type|
      get :index, :type => type
      assert_response :success
      assert_not_nil assigns(:groupings)
    end
  end

  def test_should_get_new
    login_as :user

    ValidTypes.each do |type|
      get :new, :type => type
      assert_response :success
      assert_not_nil assigns(:grouping)
    end
  end

  def test_should_create_grouping
    login_as :user
    
    ValidTypes.each do |type|
      assert_difference('Grouping.count') do
        post :create, :grouping => { :name => 'abc' }, :type => type
      end
      assert assigns(:grouping)
      assert assigns(:grouping).class.to_s == "#{type}Grouping"
      assert_redirected_to assigns(:grouping)
    end
  end

  def test_should_show_grouping
    login_as :user
    get :show, :id => groupings(:one).id # TestSubject Grouping
    assert_response :success

    get :show, :id => groupings(:five).id # Experiment Grouping
    assert_response :success

    get :show, :id => groupings(:four).id # Sample Grouping
    assert_response :success
  end

  def test_should_get_edit
    login_as :user
    ValidTypes.each do |type|
      get :edit, :id => groupings(:one).id
      assert_response :success
    end
  end

  def test_should_update_grouping
    login_as :user
    
    put :update, :id => groupings(:one).id, :grouping => { }
    assert_redirected_to grouping_path(assigns(:grouping))
  end

  def test_should_destroy_grouping
    login_as :user
    assert_difference('Grouping.count', -1) do
      delete :destroy, :id => groupings(:one).id
    end

    assert_redirected_to groupings_path
  end
end
