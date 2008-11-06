class Patient < ActiveRecord::Base
  has_many :samples, :dependent => :destroy
  
  has_many :cohort_assignments, :as => :assignable, :dependent => :destroy
  has_many :cohorts, :through => :cohort_assignments
  
  has_many :medications
  has_many :patient_evaluations
  has_many :cholesterols, :order => 'tested_at ASC'
  has_many :creatinines, :order => 'tested_at ASC'
  
  validates_presence_of :code
  validates_numericality_of :height, :weight, :greater_than => 0, :allow_blank => true
  validates_inclusion_of :gender, :in => ['Male', 'Female'], :allow_blank => true, :message => 'must be either Male or Female'
  
  def name
    "#{self.first_name} #{self.middle_name} #{self.last_name}".gsub(/\s+/, " ").strip
  end
end
