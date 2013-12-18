class AddPrepToSamples < ActiveRecord::Migration
  def self.up
    add_column :samples, :prepped_by_id, :integer
    add_column :samples, :dss_concentration, :float
    add_column :samples, :dss_lot, :string
    add_column :samples, :protocol_id, :integer
  end

  def self.down
    remove_column :samples, :protocol_id
    remove_column :samples, :dss_lot
    remove_column :samples, :dss_concentration
    remove_column :samples, :prepped_by_id
  end
end
