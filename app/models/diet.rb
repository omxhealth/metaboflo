class Diet < ActiveRecord::Base
  has_many :diet_ingredients
  has_many :ingredients, :through => :diet_ingredients
end
