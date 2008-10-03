class Sample < ActiveRecord::Base
  belongs_to :patient
  has_many :data_files
  
  validates_presence_of :patient_id
  validates_numericality_of :amount, :greater_than_or_equal => 0, :allow_blank => true
  validates_inclusion_of :unit, :in => ['ml', 'g'], :allow_blank => true

  # belongs_to :taken_by, :class_name => 'User', :foreign_key => 'taken_by_id'

  def validate
    if (patient and patient.birthdate and taken_on and patient.birthdate > taken_on)
      errors.add(:taken_on, "The sample cannot be taken before the patient's birth date")
    end
  end

end
