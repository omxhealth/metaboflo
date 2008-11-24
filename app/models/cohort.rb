class Cohort < ActiveRecord::Base
  has_many :cohort_assignments, :dependent => :destroy
  
  validates_presence_of :name, :type

  def assignable_type
    self.class.to_s.sub(/Cohort$/, '')
  end

  def self.factory(type, params = nil)
    class_name = type + 'Cohort'
    class_name.constantize.new(params)
  end
    
  # Get a list of possible cohort subclasses
  def Cohort.valid_types
    return ['Patient', 'Sample', 'Experiment']
    # Use the object space to get the subclasses and remove the Cohort itself)
    # klasses = ObjectSpace.enum_for(:each_object, class << self; self; end).to_a - [ self ]
    # klasses.collect { |klass| klass.to_s }.sort
  end
  
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
