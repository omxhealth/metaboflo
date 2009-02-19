class CreateMedications < ActiveRecord::Migration
  def self.up
    create_table :medications do |t|
      t.references :animal
      t.string :drug
      t.date :started_on
      t.date :stopped_on
      t.boolean :currently_taking
      t.string :drugbank_reference

      t.timestamps
    end
  end

  def self.down
    drop_table :medications
  end
end
