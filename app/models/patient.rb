class Patient < ActiveRecord::Base
  belongs_to :site
  
  has_many :samples, :dependent => :destroy
  
  has_many :cohort_assignments, :as => :assignable, :dependent => :destroy
  has_many :cohorts, :through => :cohort_assignments
  
  has_many :medications
  has_many :patient_evaluations
  has_many :lab_tests, :order => 'collected_at ASC'
  
  validates_presence_of :code, :site_id
  validates_inclusion_of :gender, :in => ['Male', 'Female'], :allow_blank => true, :message => 'must be either Male or Female'
  
  def name
    "#{self.first_name} #{self.middle_name} #{self.last_name}".gsub(/\s+/, " ").strip
  end
  
  # Required so that Experiments, Samples, and Patients can be displayed in cohorts
  def to_s
    return self.name
  end
  
end
