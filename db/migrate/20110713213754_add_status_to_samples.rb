class AddStatusToSamples < ActiveRecord::Migration
  def self.up
    change_table :samples do |t|
      t.string :status
    end
  end

  def self.down
    change_table :samples do |t|
      t.remove :status
    end
  end
end
