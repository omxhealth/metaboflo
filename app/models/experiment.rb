class Experiment < ActiveRecord::Base
  belongs_to :sample
  has_many :data_files
  
  has_many :cohort_assignments, :as => :assignable, :dependent => :destroy
  has_many :cohorts, :through => :cohort_assignments
  
  validates_presence_of :sample_id
end
