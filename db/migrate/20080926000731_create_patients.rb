class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.references :site
      t.string :code
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :address
      t.string :address_2
      t.string :city
      t.string :province_state
      t.string :country
      t.string :postal_zip_code
      t.date :birthdate
      t.string :blood_type
      t.string :gender
      t.string :ethnicity
      t.string :race
      t.float :height
      t.float :weight
      t.string :education
      t.string :marital_status
      t.string :practitioner
      t.text :notes
      
      t.timestamps
    end
  end

  def self.down
    drop_table :patients
  end
end
