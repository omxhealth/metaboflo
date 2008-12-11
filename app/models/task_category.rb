class TaskCategory < ActiveRecord::Base
  has_many :tasks, :foreign_key => 'category_id'
end
