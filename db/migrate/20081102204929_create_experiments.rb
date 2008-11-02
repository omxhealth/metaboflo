class CreateExperiments < ActiveRecord::Migration
  def self.up
    create_table :experiments do |t|
      t.string :name
      t.date :performed_on
      t.string :performed_by
      t.float :amount_used
      t.string :amount_used_unit
      t.text :protocol
      t.references :sample

      t.timestamps
    end
  end

  def self.down
    drop_table :experiments
  end
end
