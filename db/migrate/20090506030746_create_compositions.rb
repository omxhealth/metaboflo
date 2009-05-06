class CreateCompositions < ActiveRecord::Migration
  def self.up
    create_table :compositions do |t|
      t.references :diet
      t.references :nutrient
      t.float :amount
      
      t.timestamps
    end
  end

  def self.down
    drop_table :compositions
  end
end
