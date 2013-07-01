class CreateAndChangeColumnsOfSampleManifest < ActiveRecord::Migration
  def up
    remove_column :tissue_sample_manifests, :tissue_weight
    add_column :tissue_sample_manifests, :tissue_weight, :decimal
    remove_column :biofluid_sample_manifests, :sample_volume
    add_column :biofluid_sample_manifests, :sample_volume , :decimal

    add_column :sample_manifests, :client_institution, :string
    add_column :sample_manifests, :submitter_email, :string
    add_column :sample_manifests, :pi_email, :string

    add_column :biofluid_sample_manifests, :volume_units, :string
    add_column :tissue_sample_manifests, :weight_units, :string
  end

  def down
    
    remove_column :tissue_sample_manifests, :tissue_weight
    add_column :tissue_sample_manifests, :tissue_weight, :string
    remove_column :biofluid_sample_manifests, :sample_volume
    add_column :biofluid_sample_manifests, :sample_volume , :string

    remove_column :sample_manifests, :client_institution
    remove_column :sample_manifests, :submitter_email
    remove_column :sample_manifests, :pi_email

    remove_column :biofluid_sample_manifests, :volume_units
    remove_column :tissue_sample_manifests, :weight_units
  end
end
