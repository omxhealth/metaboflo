module TasksHelper

  def render_task_tooltip(task)
    (link_to task.to_s, task_path(task)) + ": #{h(task.description)}<br /><br />".html_safe +
      "<strong>Start</strong>: #{task.start_date}<br />".html_safe +
      "<strong>Due date</strong>: #{task.due_date}<br />".html_safe +
      "<strong>Assigned to</strong>: #{task.assigned_to.to_s if task.assigned_to}<br />".html_safe +
      "<strong>Priority</strong>: #{task.priority.name if task.priority}".html_safe
  end

end
