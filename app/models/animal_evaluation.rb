class AnimalEvaluation < ActiveRecord::Base
  belongs_to :animal
  
  validates_presence_of :animal_id
  
  serialize :past_medical, Array
  serialize :symptoms, Array

  validates_numericality_of :height, :weight, :greater_than => 0, :allow_blank => true

end
