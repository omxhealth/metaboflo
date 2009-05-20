class LabTest < ActiveRecord::Base
  belongs_to :test_subject
  
  validates_presence_of :test_subject_id
end
