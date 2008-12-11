class CreateTaskPriorities < ActiveRecord::Migration
  def self.up
    create_table :task_priorities do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :task_priorities
  end
end
