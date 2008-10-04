class Cohort < ActiveRecord::Base
  has_many :cohort_assignments, :dependent => :destroy
  has_many :patients, :through => :cohort_assignments
  
  validates_presence_of :name
end
