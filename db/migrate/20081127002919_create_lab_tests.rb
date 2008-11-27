class CreateLabTests < ActiveRecord::Migration
  def self.up
    create_table :lab_tests do |t|
      t.float :cholesterol_value
      t.string :cholesterol_unit
      t.datetime :cholesterol_tested_at
      t.float :creatinine_value
      t.string :creatinine_unit
      t.datetime :creatinine_tested_at
      t.references :patient
      t.datetime :collected_at

      t.timestamps
    end
  end

  def self.down
    drop_table :lab_tests
  end
end
