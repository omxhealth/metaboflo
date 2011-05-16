module Workflows::ExperimentsHelper
  # Prepares a new experiment for creation (via form) by adding the required number of nested associations
  def setup_workflow_experiment(experiment)
    experiment.tap do |e|
      e.build_sample if e.sample.nil?
      e.data_files.build until e.data_files.size == 2
    end
  end
end
