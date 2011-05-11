class CreateProtocols < ActiveRecord::Migration
  def self.up
    create_table :protocols do |t|
      t.string :name
      t.string :version
      t.string :comments
      t.string :storage_file_name
      t.string :storage_content_type
      t.integer :storage_file_size
      t.datetime :data_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :protocols
  end
end
