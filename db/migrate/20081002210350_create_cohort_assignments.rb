class CreateCohortAssignments < ActiveRecord::Migration
  def self.up
    create_table :cohort_assignments do |t|
      t.references :patient
      t.references :cohort

      t.timestamps
    end
  end

  def self.down
    drop_table :cohort_assignments
  end
end
