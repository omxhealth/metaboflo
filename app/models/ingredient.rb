class Ingredient < ActiveRecord::Base
  has_many :diet_ingredients
  has_many :diets, :through => :diet_ingredients
end
