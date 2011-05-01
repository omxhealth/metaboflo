class CreateTestSubjects < ActiveRecord::Migration
  def self.up
    create_table :test_subjects do |t|
      
      #Cow-specific fields
      t.text :subspecies
      t.date :calving_date
      t.integer :lactation_number
      t.date :experiment_start_date
      t.integer :days_in_milk_at_start
      t.date :experiment_end_date
      t.integer :days_in_milk_at_end
      
      #Patient-specific fields
      t.string :first_initial
      t.string :middle_initial
      t.string :last_initial
      t.string :blood_type
      t.string :gender
      t.string :race
      t.string :practitioner
      
      #Generic fields
      t.string :code
      t.date :birthdate
      t.references :site
      t.text :notes
      
      t.timestamps
    end
  end

  def self.down
    drop_table :test_subjects
  end
end
