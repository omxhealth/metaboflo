class CreateGroupingAssignments < ActiveRecord::Migration
  def self.up
    create_table :grouping_assignments do |t|
      t.string :type
      t.string :label
      t.references :grouping
      t.references :assignable, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :grouping_assignments
  end
end
