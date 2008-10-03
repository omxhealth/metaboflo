class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.references :patient
      t.float :amount
      t.string :unit
      t.string :barcode
      t.date :taken_on
      t.integer :taken_by
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :samples
  end
end
