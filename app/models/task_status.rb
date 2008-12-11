class TaskStatus < ActiveRecord::Base
  has_many :tasks, :foreign_key => 'task_id'
end
