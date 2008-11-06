class Cohort < ActiveRecord::Base
  has_many :cohort_assignments, :dependent => :destroy
  
  validates_presence_of :name
end

class PatientCohort < Cohort
  has_many :assignables, :through => :cohort_assignments, :source_type => 'Patient'
  alias_method :patients, :assignables
end

class SampleCohort < Cohort
  has_many :assignables, :through => :cohort_assignments, :source_type => 'Sample'
  alias_method :samples, :assignables
end

class ExperimentCohort < Cohort
  has_many :assignables, :through => :cohort_assignments, :source_type => 'Experiment'
  alias_method :experiments, :assignables
end
