class ChangeSampleFields < ActiveRecord::Migration
  def up
    remove_column :tissue_sample_manifests, :tissue_weight
    add_column :tissue_sample_manifests, :tissue_weight, :integer
    
    remove_column :tissue_sample_manifests, :group_id
    add_column :tissue_sample_manifests, :group_id, :integer
    
    remove_column :cell_sample_manifests, :group_id
    add_column :cell_sample_manifests, :group_id, :integer
    
    remove_column :biofluid_sample_manifests, :group_id
    add_column :biofluid_sample_manifests, :group_id, :integer
    
    add_column :sample_manifests, :grant_id, :string 
  end

  def down
    remove_column :tissue_sample_manifests, :tissue_weight
    add_column :tissue_sample_manifests, :tissue_weight, :decimal
    
    remove_column :tissue_sample_manifests, :group_id
    add_column :tissue_sample_manifests, :group_id, :string
    
    remove_column :cell_sample_manifests, :group_id
    add_column :cell_sample_manifests, :group_id, :string
    
    remove_column :biofluid_sample_manifests, :group_id
    add_column :biofluid_sample_manifests, :group_id, :string
    
    remove_column :sample_manifests, :grant_id
  end
end
