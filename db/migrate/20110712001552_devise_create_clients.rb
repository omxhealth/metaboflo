class DeviseCreateClients < ActiveRecord::Migration
  def self.up
    create_table(:clients) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      t.encryptable
      # t.confirmable
      t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      # Custom columns
      t.string :name
      t.string :affiliation
      t.string :phone
      t.string :address
      t.string :city
      t.string :province_state
      t.string :country
      t.string :postal_zip_code
      t.text :notes
      
      t.string :primary_name
      t.string :primary_email
      t.string :primary_phone
      t.string :secondary_name
      t.string :secondary_email
      t.string :secondary_phone
      
      t.timestamps
    end

    add_index :clients, :email,                :unique => true
    add_index :clients, :reset_password_token, :unique => true
    # add_index :clients, :confirmation_token,   :unique => true
    # add_index :clients, :unlock_token,         :unique => true
    # add_index :clients, :authentication_token, :unique => true
  end

  def self.down
    drop_table :clients
  end
end
