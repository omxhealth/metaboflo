class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :subject
      t.string :description
      t.integer :status_id
      t.integer :priority_id
      t.integer :assigned_to_id
      t.integer :category_id
      t.date :start_date
      t.date :due_date
      t.float :estimated_hours
      t.integer :done_ratio

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
