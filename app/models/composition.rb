class Composition < ActiveRecord::Base
  belongs_to :diet
  belongs_to :nutrient
  
  # validates_presence_of :diet_id
  validates_presence_of :nutrient_id
  # validates_uniqueness_of :diet_id, :scope => :nutrient_id, :allow_blank => true
end
