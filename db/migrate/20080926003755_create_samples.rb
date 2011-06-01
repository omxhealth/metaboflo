class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.references :test_subject
      t.references :sample
      t.references :site
      t.string :sample_type
      t.float :original_amount
      t.string :original_unit
      t.float :actual_amount
      t.string :actual_unit
      t.string :barcode
      t.string :building
      t.string :room
      t.string :freezer
      t.string :shelf
      t.string :box
      t.string :box_position
      t.date :collected_on
      t.integer :collected_by_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :samples
  end
end
