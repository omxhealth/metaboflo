class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.references :patient
      t.references :sample
      t.string :sample_type
      t.float :original_amount
      t.string :original_unit
      t.float :actual_amount
      t.string :actual_unit
      t.string :barcode
      t.references :site
      t.string :building
      t.string :room
      t.text :storage_location
      t.date :collected_on
      t.integer :collected_by
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :samples
  end
end
