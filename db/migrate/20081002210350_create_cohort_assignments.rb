class CreateCohortAssignments < ActiveRecord::Migration
  def self.up
    create_table :cohort_assignments do |t|
      t.string :type
      t.string :label
      t.references :cohort
      t.references :assignable, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :cohort_assignments
  end
end
