class CreateStoredFiles < ActiveRecord::Migration
  def self.up
    create_table :stored_files do |t|
      t.string :type
      t.references :attachable
      t.string :attachable_type
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :stored_files
  end
end
