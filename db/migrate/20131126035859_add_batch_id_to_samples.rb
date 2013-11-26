class AddBatchIdToSamples < ActiveRecord::Migration
  def self.up
    change_table :samples do |t|
      t.references :batch
    end
  end

  def self.down
    change_table :samples do |t|
      t.remove :batch_id
    end
  end
end
