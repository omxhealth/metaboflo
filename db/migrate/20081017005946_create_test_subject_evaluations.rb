class CreateTestSubjectEvaluations < ActiveRecord::Migration
  def self.up
    create_table :test_subject_evaluations do |t|
      t.references :test_subject
      t.text :diagnosis
      t.float :height
      t.float :weight
      t.string :education
      t.string :marital_status
      t.string :address
      t.string :address_2
      t.string :city
      t.string :province_state
      t.string :country
      t.string :postal_zip_code
      t.boolean :current_smoker
      t.float :past_smoker
      t.float :drinking_weekly
      t.float :exercise_weekly
      t.float :hours_sleep
      t.boolean :enough_sleep
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
      t.string :past_medical, :default => '--- []'
      t.string :symptoms, :default => '--- []'
      t.date :evaluated_on

      t.timestamps
    end
  end

  def self.down
    drop_table :test_subject_evaluations
  end
end
