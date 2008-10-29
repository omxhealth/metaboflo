class PatientEvaluation < ActiveRecord::Base
  belongs_to :patient
  
  validates_presence_of :patient_id
  
  serialize :past_medical, Array
  serialize :symptoms, Array

end
