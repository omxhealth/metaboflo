class CreatePatientEvaluations < ActiveRecord::Migration
  def self.up
    create_table :patient_evaluations do |t|
      t.references :patient
      t.text :diagnosis
      t.boolean :current_smoker
      t.float :past_smoker
      t.float :drinking_weekly
      t.float :exercise_weekly
      t.float :hours_sleep
      t.boolean :enough_sleep
      t.text :past_medical
      t.integer :father_age
      t.string :father_health
      t.integer :father_death_age
      t.string :father_death_cause
      t.integer :mother_age
      t.string :mother_health
      t.integer :mother_death_age
      t.string :mother_death_cause
      t.integer :num_children
      t.string :relative_condition
      t.string :relative_relationship
      t.date :evaluated_on

      t.timestamps
    end
  end

  def self.down
    drop_table :patient_evaluations
  end
end
