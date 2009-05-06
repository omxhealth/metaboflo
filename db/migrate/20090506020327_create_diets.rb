class CreateDiets < ActiveRecord::Migration
  def self.up
    create_table :diets do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :diets
  end
end
