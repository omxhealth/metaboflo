class CreateDietIngredients < ActiveRecord::Migration
  def self.up
    create_table :diet_ingredients do |t|
      t.references :diet
      t.references :ingredient
      t.float :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :diet_ingredients
  end
end
