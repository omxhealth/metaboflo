class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string :code
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :birthdate
      t.string :gender
      t.float :height
      t.float :weight

      t.timestamps
    end
  end

  def self.down
    drop_table :patients
  end
end
