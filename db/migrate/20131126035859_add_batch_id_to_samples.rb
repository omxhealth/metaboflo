class AddBatchIdToSamples < ActiveRecord::Migration
  def self.up
    add_column :samples, :batch_id, :integer

    add_column :samples, :collection_location, :string

    add_column :samples, :prepped_by_id, :integer
    add_column :samples, :dss_concentration, :float
    add_column :samples, :dss_lot, :string
    add_column :samples, :protocol_id, :integer

    add_column :samples, :corrected_by_id, :integer
  end

  def self.down
    remove_column :samples, :batch_id

    remove_column :samples, :protocol_id
    remove_column :samples, :dss_lot
    remove_column :samples, :dss_concentration
    remove_column :samples, :prepped_by_id

    remove_column :samples, :collection_location

    remove_column :samples, :corrected_by_id
  end
end
