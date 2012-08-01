class CreateSampleManifestModels < ActiveRecord::Migration
  def self.up
    
    create_table :sample_manifests do |t|
      t.integer :client_id
      t.string :title
      t.boolean :verified, :default => false
      t.boolean :shipped, :default => false
    end
    
    create_table :tissue_sample_manifests do |t|
      t.integer :sample_manifest_id
      t.integer :tube_id
      t.string :barcode
      t.string :species
      t.string :matrix
      t.string :group_id
      t.string :tissue_weight
      t.boolean :module_1
      t.boolean :module_2
      t.boolean :module_3
      t.boolean :module_4
      t.boolean :module_5
      t.boolean :gc_fap
      t.boolean :ss_1
      t.boolean :ss_2
      t.timestamps
    end
    
    create_table :cell_sample_manifests do |t|
      t.integer :sample_manifest_id
      t.integer :tube_id
      t.string :barcode
      t.string :cell_line
      t.string :group_id
      t.integer :viable_cells
      t.boolean :module_1
      t.boolean :module_2
      t.boolean :module_3
      t.boolean :module_4
      t.boolean :module_5
      t.boolean :gc_fap
      t.boolean :ss_1
      t.boolean :ss_2
      t.timestamps
    end
    
    create_table :biofluid_sample_manifests do |t|
      t.integer :sample_manifest_id
      t.integer :tube_id
      t.string :barcode
      t.string :species
      t.string :matrix
      t.string :group_id
      t.string :sample_volume
      t.boolean :module_1
      t.boolean :module_2
      t.boolean :module_3
      t.boolean :module_4
      t.boolean :module_5
      t.boolean :gc_fap
      t.boolean :ss_1
      t.boolean :ss_2
      t.timestamps
    end
  end

  def self.down
    drop_table :sample_manifests
    drop_table :cell_sample_manifests
    drop_table :tissue_sample_manifests
    drop_table :biofluid_sample_manifests

  end
end
