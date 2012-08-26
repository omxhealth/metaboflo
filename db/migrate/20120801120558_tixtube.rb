class Tixtube < ActiveRecord::Migration
  def self.up
    change_column :tissue_sample_manifests, :tube_id , :string
    change_column :cell_sample_manifests, :tube_id , :string
    change_column :biofluid_sample_manifests, :tube_id , :string
  end

  def self.down
    change_column :tissue_sample_manifests, :tube_id , :integer
    change_column :cell_sample_manifests, :tube_id , :integer
    change_column :biofluid_sample_manifests, :tube_id, :integer

  end
end
