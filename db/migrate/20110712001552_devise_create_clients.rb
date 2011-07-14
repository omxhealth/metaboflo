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
