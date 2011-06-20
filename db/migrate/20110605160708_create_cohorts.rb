class CreateCohorts < ActiveRecord::Migration
  def self.up
    create_table :cohorts do |t|
      t.references :study
      t.string :label
      t.string :control

      t.timestamps
    end
    
    add_index :cohorts, :study_id
  end

  def self.down
    drop_table :cohorts
  end
end
