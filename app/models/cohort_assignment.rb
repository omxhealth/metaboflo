class CohortAssignment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :cohort
  
  validates_presence_of :patient_id, :cohort_id
  validates_uniqueness_of :patient_id, :scope => :cohort_id
end
