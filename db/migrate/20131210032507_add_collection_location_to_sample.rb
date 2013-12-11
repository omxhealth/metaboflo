class AddCollectionLocationToSample < ActiveRecord::Migration
  def self.up
    add_column :samples, :collection_location, :string
    add_column :samples, :prepped, :boolean, :default => false
  end

  def self.down
    remove_column :samples, :collection_location
    remove_column :samples, :prepped
  end
end
