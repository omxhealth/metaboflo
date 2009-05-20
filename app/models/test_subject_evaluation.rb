class TestSubjectEvaluation < ActiveRecord::Base
  belongs_to :test_subject
  
  validates_presence_of :test_subject_id
  
  serialize :past_medical, Array
  serialize :symptoms, Array

  validates_numericality_of :height, :weight, :greater_than => 0, :allow_blank => true

end
