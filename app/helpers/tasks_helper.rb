module TasksHelper

  def render_task_tooltip(task)
    (link_to task.to_s, task_path(task)) + ": #{h(task.description)}<br /><br />" +
      "<strong>Start</strong>: #{task.start_date}<br />" +
      "<strong>Due date</strong>: #{task.due_date}<br />" +
      "<strong>Assigned to</strong>: #{task.assigned_to.login if task.assigned_to}<br />" +
      "<strong>Priority</strong>: #{task.priority.name if task.priority}"
  end

end
