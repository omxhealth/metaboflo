class ExperimentGrouping < Grouping
  has_many :assignables, :through => :grouping_assignments, :source_type => 'Experiment'
  alias_method :experiments, :assignables
end

