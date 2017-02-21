class Diet < ActiveRecord::Base
  has_many :diet_ingredients
  has_many :ingredients, through: :diet_ingredients

  has_many :compositions
  has_many :nutrients, through: :compositions

  has_many :meals
  has_many :test_subjects, through: :meals

  # Allow the form for diets to update/create/delete diet_ingredients
  accepts_nested_attributes_for :diet_ingredients,
    allow_destroy: true,
    reject_if: proc { |attrs| attrs.all? { |k, v| v.blank? } }

  # Allow the form for diets to update/create/delete compositions
  accepts_nested_attributes_for :compositions,
    allow_destroy: true,
    reject_if: proc { |attrs| attrs.all? { |k, v| v.blank? } }

  validates_presence_of :name
  validates_uniqueness_of :name, allow_blank: true
end
