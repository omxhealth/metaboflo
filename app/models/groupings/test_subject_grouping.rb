class TestSubjectGrouping < Grouping
  has_many :assignables, through: :grouping_assignments, source_type: 'TestSubject'
  alias_method :test_subjects, :assignables
end
