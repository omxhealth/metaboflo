class CreateMedications < ActiveRecord::Migration
  def self.up
    create_table :medications do |t|
      t.references :patient
      t.string :drug
      t.date :started_on
      t.date :stopped_on

      t.timestamps
    end
  end

  def self.down
    drop_table :medications
  end
end
