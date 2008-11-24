class Sample < ActiveRecord::Base
  belongs_to :patient
  belongs_to :sample
  
  has_many :samples
  has_many :experiments
  
  has_many :cohort_assignments, :as => :assignable, :dependent => :destroy
  has_many :cohorts, :through => :cohort_assignments
  
  validates_numericality_of :amount, :greater_than_or_equal => 0, :allow_blank => true
  validates_inclusion_of :unit, :in => ['ml', 'g'], :allow_blank => true

  # belongs_to :collected_by, :class_name => 'User', :foreign_key => 'collected_by_id'
  
  # Required so that Experiments, Samples, and Patients can be displayed in cohorts
  def to_s
    return "#{self.barcode} (#{sample_type} - #{amount} #{unit})"
  end
  
  def validate
    if (patient and patient.birthdate and collected_on and patient.birthdate > collected_on)
      errors.add(:collected_on, "The sample cannot be taken before the patient's birth date")
    end
  end

  def before_validation
    self.sample_type = self.sample.sample_type if self.sample
  end
  
  def root
    current_sample = self
    while current_sample.patient.nil?
      current_sample = current_sample.sample
    end
    current_sample.patient
  end
end
