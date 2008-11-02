class Sample < ActiveRecord::Base
  belongs_to :patient
  belongs_to :sample
  
  has_many :samples
  has_many :experiments
  
  validates_numericality_of :amount, :greater_than_or_equal => 0, :allow_blank => true
  validates_inclusion_of :unit, :in => ['ml', 'g'], :allow_blank => true

  # belongs_to :collected_by, :class_name => 'User', :foreign_key => 'collected_by_id'

  def validate
    if (patient and patient.birthdate and collected_on and patient.birthdate > collected_on)
      errors.add(:collected_on, "The sample cannot be taken before the patient's birth date")
    end
  end

  def before_validation
    self.sample_type = self.sample.sample_type if self.sample
  end
end
