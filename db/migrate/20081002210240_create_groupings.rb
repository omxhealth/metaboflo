class CreateGroupings < ActiveRecord::Migration
  def self.up
    create_table :groupings do |t|
      t.string :type
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :groupings
  end
end
