class Nutrient < ActiveRecord::Base
  has_many :compositions
  has_many :diets, :through => :compositions
end
