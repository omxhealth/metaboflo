class CreateMeals < ActiveRecord::Migration
  def self.up
    create_table :meals do |t|
      t.float :amount
      t.references :animal
      t.references :diet
      t.integer :consumed_during_period
      t.integer :consumed_on_day
      
      t.timestamps
    end
  end

  def self.down
    drop_table :meals
  end
end
