class CohortAssignment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :cohort
end
