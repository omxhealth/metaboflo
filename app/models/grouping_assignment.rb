class GroupingAssignment < ActiveRecord::Base
  belongs_to :assignable, :polymorphic => true
  belongs_to :grouping
  
  validates_presence_of :assignable_id, :grouping_id
  validates_uniqueness_of :grouping_id, :scope => [ :assignable_id, :assignable_type ]
end
