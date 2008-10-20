class CreateCreatinines < ActiveRecord::Migration
  def self.up
    create_table :creatinines do |t|
      t.references :patient
      t.datetime :collected_at
      t.datetime :tested_at
      t.float :level
      t.string :unit

      t.timestamps
    end
  end

  def self.down
    drop_table :creatinines
  end
end
