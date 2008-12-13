class CreateExperiments < ActiveRecord::Migration
  def self.up
    create_table :experiments do |t|
      t.string :name
      t.text :description
      t.date :perform_on
      t.references :assigned_to
      t.date :performed_on
      t.references :performed_by
      t.float :amount_used
      t.string :amount_used_unit
      t.references :sample
      t.references :protocol
      t.text :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :experiments
  end
end
