class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.references :patient
      t.references :sample
      t.string :sample_type
      t.float :amount
      t.string :unit
      t.string :barcode
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
