class Ingredient < ActiveRecord::Base
  has_many :diet_ingredients
  has_many :diets, :through => :diet_ingredients
  
  validates_presence_of :name
  validates_uniqueness_of :name, :allow_blank => true
end
