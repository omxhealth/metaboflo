require 'test_helper'

class StudyCohortAssignmentTest < ActiveSupport::TestCase
  
  test "adding test subject to study" do
    study = cohorts(:study)
    subject = test_subjects(:two)
    
    size = study.study_cohort_assignments.size
  
    StudyCohortAssignment.create(:label => 'Test', :cohort => study, :assignable => subject)

    assert_equal size + 1, study.study_cohort_assignments.size
  end

end
