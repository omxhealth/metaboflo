class CreateCohortsTestSubjects < ActiveRecord::Migration
  def self.up
    create_table :cohorts_test_subjects do |t|
      t.references :cohort
      t.references :test_subject

      t.timestamps
    end
    add_index :cohorts_test_subjects, [ :cohort_id, :test_subject_id ], :unique => true
  end

  def self.down
    drop_table :cohorts_test_subjects
  end
end
