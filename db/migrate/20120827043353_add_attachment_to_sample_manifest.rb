class AddAttachmentToSampleManifest < ActiveRecord::Migration
  def change
    add_attachment :sample_manifests, :file
  end
end
