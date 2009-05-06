class DietIngredient < ActiveRecord::Base
  belongs_to :diet
  belongs_to :ingredient
  
  validates_presence_of :diet_id, :ingredient_id
  validates_uniqueness_of :diet, :scope => :ingredient, :allow_blank => true
end
