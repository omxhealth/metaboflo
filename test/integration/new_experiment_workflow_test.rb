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
    get new_workflows_experiment_path
    assert_response :success
    
    # new patient form
    get new_workflows_patient_path, :format => :js
    assert_response :success
    
    # create patient
    post_via_redirect workflows_patients_path, :test_subject => { :code => 'NEW007', :site_id => users(:user).site_id, :samples_attributes => { 0 => { :sample_type => 'milk', :barcode => 'lksdjflksjdf' } } }, :format => :js
    patient = TestSubject.find_by_code('NEW007')
    assert_equal 1, patient.samples.count
    assert_response :success
    
    # create experiment
    post_via_redirect workflows_experiments_path, :experiment => { :sample_id => patient.samples.first.id, :name => 'Workflow experiment', :experiment_type_id => experiment_types(:one).id }
    experiment = Experiment.find_by_name('Workflow experiment')
    assert_equal sample_experiment_path(experiment.sample, experiment), path
  end
end
