require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "complete!" do
    task = Task.create!(:subject => 'New task', :status => TaskStatus.find_by_name('Open'), :done_ratio => 20)
    task.complete!
    
    task = Task.find(task.id)
    assert_equal TaskStatus.find_by_name('Closed'), task.status
    assert_equal 100, task.done_ratio
  end
end
