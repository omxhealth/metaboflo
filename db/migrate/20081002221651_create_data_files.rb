class CreateDataFiles < ActiveRecord::Migration
  def self.up
    create_table :data_files do |t|
      t.references :experiment
      t.string :data_file_name
      t.string :data_content_type
      t.integer :data_file_size
      t.datetime :data_updated_at
      t.text :description
      t.boolean :has_concentrations
      t.string :has_concentration_units
      t.string :mapping_errors
      t.references :data_file_type

      t.timestamps
    end
  end

  def self.down
    drop_table :data_files
  end
end
