class StudyCohortAssignment < CohortAssignment
  belongs_to :study, :foreign_key => 'cohort_id'
  validates_presence_of :label
end
