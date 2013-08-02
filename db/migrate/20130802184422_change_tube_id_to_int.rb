class ChangeTubeIdToInt < ActiveRecord::Migration
  def up
    remove_column :tissue_sample_manifests, :tube_id
    add_column :tissue_sample_manifests, :tube_id, :integer 
    
    remove_column :biofluid_sample_manifests, :tube_id
    add_column :biofluid_sample_manifests, :tube_id, :integer 
    
    remove_column :cell_sample_manifests, :tube_id
    add_column :cell_sample_manifests, :tube_id, :integer 
  end

  def down
    remove_column :tissue_sample_manifests, :tube_id
    add_column :tissue_sample_manifests, :tube_id, :string
    
    remove_column :biofluid_sample_manifests, :tube_id
    add_column :biofluid_sample_manifests, :tube_id, :string 
    
    remove_column :cell_sample_manifests, :tube_id
    add_column :cell_sample_manifests, :tube_id, :string 

  end
end
