module Workflows::StudiesHelper
  # Prepares a new study for creation (via form) by adding the required number of nested associations
  def setup_workflow_study(study)
    study.tap do |s|
      s.cohorts.build until s.cohorts.size == 2
    end
  end

end
