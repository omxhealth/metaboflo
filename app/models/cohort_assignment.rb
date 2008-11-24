class CohortAssignment < ActiveRecord::Base
  belongs_to :assignable, :polymorphic => true
  belongs_to :cohort
  
  validates_presence_of :assignable_id, :cohort_id
  validates_uniqueness_of :cohort_id, :scope => [ :assignable_id, :assignable_type ]
end
