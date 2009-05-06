class CreateAnimals < ActiveRecord::Migration
  def self.up
    create_table :animals do |t|
      t.string :code
      t.text :breed
      t.date :birthdate
      t.date :calving_date
      t.integer :lactation_number
      t.date :experiment_start_date
      t.integer :days_in_milk_at_start
      t.date :experiment_end_date
      t.integer :days_in_milk_at_end
      t.text :notes
      t.references :site
      
      t.timestamps
    end
  end

  def self.down
    drop_table :animals
  end
end
