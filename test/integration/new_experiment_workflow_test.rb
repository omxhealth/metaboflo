require 'test_helper'

class NewExperimentWorkflowTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "new workflow with new patient" do
    get new_user_session_path
    assert_response :success

    # login
    post_via_redirect new_user_session_path, :user => { :email => users(:user).email, :password => 'monkey' }
    assert_equal root_path, path
    
    # start new experiment workflow
    get workflows_experiments_path
    assert_response :success
    
    # new patient form
    get new_workflows_patient_path
    assert_response :success
    
    # create patient
    post_via_redirect workflows_patients_path, :test_subject => { :code => 'NEW007', :site_id => users(:user).site_id }
    sample_id = TestSubject.find_by_code('NEW007').samples.first.to_param
    assert_equal new_workflows_sample_experiment_path(sample_id), path
    
    # create experiment
    post_via_redirect workflows_sample_experiments_path(sample_id), :experiment => { :sample_id => sample_id, :name => 'Workflow experiment', :experiment_type_id => experiment_types(:one).id }
    assert_equal sample_experiment_path(sample_id, Experiment.find_by_name('Workflow experiment')), path
  end
end
