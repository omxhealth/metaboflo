class Cholesterol < ActiveRecord::Base
  belongs_to :patient
  
  validates_presence_of :patient_id, :tested_at, :level, :unit
end
