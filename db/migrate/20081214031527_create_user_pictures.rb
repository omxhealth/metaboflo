class CreateUserPictures < ActiveRecord::Migration
  def self.up
    create_table :user_pictures do |t|
      t.integer :size
      t.string :content_type
      t.string :filename
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :user_pictures
  end
end
