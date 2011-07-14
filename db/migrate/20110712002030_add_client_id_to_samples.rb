class AddClientIdToSamples < ActiveRecord::Migration
  def self.up
    change_table :samples do |t|
      t.references :client
    end
  end

  def self.down
    change_table :samples do |t|
      t.remove :client_id
    end
  end
end
