class CreateCorrections < ActiveRecord::Migration
  def self.up
    create_table :corrections do |t|
      t.references :sample
      t.float :initial_ph
      t.float :final_ph
      t.float :buffer_amount

      t.timestamps
    end
  end

  def self.down
    drop_table :corrections
  end
end
