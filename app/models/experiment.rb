class Experiment < ActiveRecord::Base

  belongs_to :sample
  belongs_to :protocol
  has_many :data_files
  
  has_many :cohort_assignments, :as => :assignable, :dependent => :destroy
  has_many :cohorts, :through => :cohort_assignments
  
  validates_presence_of :sample_id, :name
  
  # Required so that Experiments, Samples, and Patients can be displayed in cohorts
  def to_s
    return self.name
  end

end
