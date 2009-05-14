class CreateMeals < ActiveRecord::Migration
  def self.up
    create_table :meals do |t|
      t.float :amount
      t.references :animal
      t.references :diet
      t.date :consumed_on
      
      t.timestamps
    end
  end

  def self.down
    drop_table :meals
  end
end
