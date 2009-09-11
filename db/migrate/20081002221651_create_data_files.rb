class CreateDataFiles < ActiveRecord::Migration
  def self.up
    create_table :data_files do |t|
      t.integer :size
      t.string :content_type
      t.string :filename
      t.text :description
      t.boolean :has_concentrations
      t.string :has_concentration_units
      t.string :mapping_errors
      t.references :data_file_type
      t.references :experiment

      t.timestamps
    end
  end

  def self.down
    drop_table :data_files
  end
end
