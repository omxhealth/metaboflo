class AddCollectionLocationToSample < ActiveRecord::Migration
  def self.up
    add_column :samples, :collection_location, :string
  end

  def self.down
    remove_column :samples, :collection_location
  end
end
