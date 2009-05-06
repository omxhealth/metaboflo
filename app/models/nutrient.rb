class Nutrient < ActiveRecord::Base
  has_many :compositions
  has_many :diets, :through => :compositions
  
  validates_presence_of :name
  validates_uniqueness_of :name, :allow_blank => true
end
