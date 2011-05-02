class Task < ActiveRecord::Base
  belongs_to :status, :class_name => 'TaskStatus'
  belongs_to :priority, :class_name => 'TaskPriority'
  belongs_to :category, :class_name => 'TaskCategory'
  belongs_to :assigned_to, :class_name => 'User'
  
  validates_presence_of :subject
  validates_numericality_of :done_ratio, :allow_blank => true
  validates_numericality_of :estimated_hours, :allow_blank => true
  
  def complete!
    self.status = TaskStatus.find_by_name('Closed')
    self.done_ratio = 100
    self.save! unless self.new_record?
  end
  
  # Returns the due date or the target due date if any
  # Used on gantt chart
  def due_before
    return self.due_date
  end
  
  def duration
    (start_date && due_date) ? due_date - start_date : 0
  end
  
  def soonest_start
    @soonest_start ||= relations_to.collect{|relation| relation.successor_soonest_start}.compact.min
  end

  def to_s
    "#{subject} ##{id}"
  end
end
