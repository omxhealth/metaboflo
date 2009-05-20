class Meal < ActiveRecord::Base

  belongs_to :test_subject
  belongs_to :diet
  
  validates_presence_of :test_subject_id, :diet_id, :amount, :consumed_on_day, :consumed_during_period
  
end
