class CreateConcentrations < ActiveRecord::Migration
  def self.up
    create_table :concentrations do |t|
      t.float :concentration_value
      t.string :concentration_units
      t.boolean :is_experimental, :default => true
      t.references :data_file
      t.references :metabolite

      t.timestamps
    end
  end

  def self.down
    drop_table :concentrations
  end
end