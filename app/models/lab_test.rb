class LabTest < ActiveRecord::Base
  belongs_to :animal
  
  validates_presence_of :animal_id
end
