class SampleGrouping < Grouping
  has_many :assignables, through: :grouping_assignments, source_type: 'Sample'
  alias_method :samples, :assignables
end
