module Workflows::PatientsHelper
  # Prepares a new patient for creation (via form) by adding the required number of nested associations
  def setup_workflow_patient(patient)
    patient.tap do |p|
      p.samples.build if p.samples.empty?
    end
  end
end
