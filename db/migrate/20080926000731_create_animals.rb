class CreateAnimals < ActiveRecord::Migration
  def self.up
    create_table :animals do |t|
      t.references :site
      t.string :code
      t.string :first_initial
      t.string :middle_initial
      t.string :last_initial
      t.date :birthdate
      t.string :blood_type
      t.string :gender
      t.string :race
      t.string :practitioner
      t.text :notes
      
      t.timestamps
    end
  end

  def self.down
    drop_table :animals
  end
end
