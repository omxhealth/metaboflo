class CreateLabTests < ActiveRecord::Migration
  def self.up
    #Found some tests at http://www.scielo.br/img/revistas/clin/v62n5/21t1.gif
    create_table :lab_tests do |t|
      t.float :cholesterol_value
      t.string :cholesterol_unit
      t.datetime :cholesterol_tested_at
      
      t.float :creatinine_value
      t.string :creatinine_unit
      t.datetime :creatinine_tested_at
      
      t.float :urea_value
      t.string :urea_unit
      t.datetime :urea_tested_at
      
      t.float :sodium_value
      t.string :sodium_unit
      t.datetime :sodium_tested_at
      
      t.float :potassium_value
      t.string :potassium_unit
      t.datetime :potassium_tested_at
      
      t.float :hemoglobin_value
      t.string :hemoglobin_unit
      t.datetime :hemoglobin_tested_at
      
      t.float :white_cell_count_value
      t.string :white_cell_count_unit
      t.datetime :white_cell_count_tested_at
      
      t.float :glucose_value
      t.string :glucose_unit
      t.datetime :glucose_tested_at
      
      t.float :protein_value
      t.string :protein_unit
      t.datetime :protein_tested_at
      
      t.float :c_reactive_protein_value
      t.string :c_reactive_protein_unit
      t.datetime :c_reactive_protein_tested_at
      
      t.references :animal
      t.datetime :collected_at
      t.text :notes
      
      t.timestamps
    end
  end

  def self.down
    drop_table :lab_tests
  end
end
