class AddSerialNumberToClients < ActiveRecord::Migration
  def change
    add_column :clients, :serial_number, :integer, default: 0
  end
end
