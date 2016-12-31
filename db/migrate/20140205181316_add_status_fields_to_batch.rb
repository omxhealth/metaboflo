class AddStatusFieldsToBatch < ActiveRecord::Migration
  def self.up
    add_column :batches, :prep_done, :boolean, :default => false
    add_column :batches, :ph_done, :boolean, :default => false
    add_column :batches, :run_done, :boolean, :default => false
  end

  def self.down
    remove_column :batches, :run_done
    remove_column :batches, :ph_done
    remove_column :batches, :prep_done
  end
end
