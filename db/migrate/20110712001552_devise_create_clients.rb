class DeviseCreateClients < ActiveRecord::Migration
  def self.up
    create_table(:clients) do |t|
       
       ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Encryptable
      t.string :password_salt

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      
      ## Rememberable
      t.datetime :remember_created_at

      ## Lockable
      t.integer  :failed_attempts, :default => 0
      t.string   :unlock_token 
      t.datetime :locked_at

      # Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      ## Invitable
      t.string :invitation_token

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

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
