class CreateProtocols < ActiveRecord::Migration
  def self.up
    create_table :protocols do |t|
      t.string :name
      t.string :version
      t.string :comments
      t.integer :size
      t.string :content_type
      t.string :filename

      t.timestamps
    end
  end

  def self.down
    drop_table :protocols
  end
end
