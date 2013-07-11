class UpdateModulesInManifests < ActiveRecord::Migration
  def up
    remove_column :tissue_sample_manifests, :gc_fap
    remove_column :tissue_sample_manifests, :ss_1
    remove_column :tissue_sample_manifests, :ss_2
    
    remove_column :biofluid_sample_manifests, :gc_fap
    remove_column :biofluid_sample_manifests, :ss_1
    remove_column :biofluid_sample_manifests, :ss_2
    
    remove_column :cell_sample_manifests, :gc_fap
    remove_column :cell_sample_manifests, :ss_1
    remove_column :cell_sample_manifests, :ss_2
    
    add_column :cell_sample_manifests, :species, :string
    
    add_column :tissue_sample_manifests, :module_6, :boolean
    add_column :tissue_sample_manifests, :module_7, :boolean
    add_column :tissue_sample_manifests, :module_8, :boolean
    add_column :tissue_sample_manifests, :module_9, :boolean
    add_column :tissue_sample_manifests, :module_10, :boolean
    add_column :tissue_sample_manifests, :module_11, :boolean
    add_column :tissue_sample_manifests, :module_12, :boolean
    
    add_column :biofluid_sample_manifests, :module_6, :boolean
    add_column :biofluid_sample_manifests, :module_7, :boolean
    add_column :biofluid_sample_manifests, :module_8, :boolean
    add_column :biofluid_sample_manifests, :module_9, :boolean
    add_column :biofluid_sample_manifests, :module_10, :boolean
    add_column :biofluid_sample_manifests, :module_11, :boolean
    add_column :biofluid_sample_manifests, :module_12, :boolean
    
    add_column :cell_sample_manifests, :module_6, :boolean
    add_column :cell_sample_manifests, :module_7, :boolean
    add_column :cell_sample_manifests, :module_8, :boolean
    add_column :cell_sample_manifests, :module_9, :boolean
    add_column :cell_sample_manifests, :module_10, :boolean
    add_column :cell_sample_manifests, :module_11, :boolean
    add_column :cell_sample_manifests, :module_12, :boolean
    
  end

  def down
    add_column :tissue_sample_manifests, :gc_fap, :boolean
    add_column :tissue_sample_manifests, :ss_1, :boolean
    add_column :tissue_sample_manifests, :ss_2, :boolean
    
    add_column :biofluid_sample_manifests, :gc_fap, :boolean
    add_column :biofluid_sample_manifests, :ss_1, :boolean
    add_column :biofluid_sample_manifests, :ss_2, :boolean
    
    add_column :cell_sample_manifests, :gc_fap, :boolean
    add_column :cell_sample_manifests, :ss_1, :boolean
    add_column :cell_sample_manifests, :ss_2, :boolean
    
    remove_column :cell_sample_manifests, :species
    
    remove_column :tissue_sample_manifests, :module_6
    remove_column :tissue_sample_manifests, :module_7
    remove_column :tissue_sample_manifests, :module_8
    remove_column :tissue_sample_manifests, :module_9
    remove_column :tissue_sample_manifests, :module_10
    remove_column :tissue_sample_manifests, :module_11
    remove_column :tissue_sample_manifests, :module_12
    
    remove_column :biofluid_sample_manifests, :module_6
    remove_column :biofluid_sample_manifests, :module_7
    remove_column :biofluid_sample_manifests, :module_8
    remove_column :biofluid_sample_manifests, :module_9
    remove_column :biofluid_sample_manifests, :module_10
    remove_column :biofluid_sample_manifests, :module_11
    remove_column :biofluid_sample_manifests, :module_12
    
    remove_column :cell_sample_manifests, :module_6
    remove_column :cell_sample_manifests, :module_7
    remove_column :cell_sample_manifests, :module_8
    remove_column :cell_sample_manifests, :module_9
    remove_column :cell_sample_manifests, :module_10
    remove_column :cell_sample_manifests, :module_11
    remove_column :cell_sample_manifests, :module_12
  end
end