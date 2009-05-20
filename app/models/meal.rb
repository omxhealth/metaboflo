class Meal < ActiveRecord::Base

  belongs_to :animal
  belongs_to :diet
  
  validates_presence_of :animal_id, :diet_id, :amount, :consumed_on_day, :consumed_during_period
  
end
