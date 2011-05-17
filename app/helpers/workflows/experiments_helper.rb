module Workflows::ExperimentsHelper
  # Prepares a new experiment for creation (via form) by adding the required number of nested associations
  def setup_workflow_experiment(experiment)
    experiment.tap do |e|
      e.data_files.build until e.data_files.size == 2
    end
  end
  
  def options_for_workflow_sample(code)
    ts = TestSubject.where(:code => code).first
    ts.nil? ? [] : ts.samples.collect { |s| [s.to_s, s.id] }
  end
  
  def new_sample_form_for_test_subject(code)
    ts = TestSubject.where(:code => code).first
    ts.nil? ? nil : "$.ajax(\"#{new_workflows_patient_sample_path ts, :format => :js}\")".html_safe
  end
end
