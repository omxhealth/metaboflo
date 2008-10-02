class Patient < ActiveRecord::Base
  has_many :samples, :dependent => :destroy
  
  has_many :cohort_assignments, :dependent => :destroy
  has_many :cohorts, :through => :cohort_assignments
  
  def name
    "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end
end
