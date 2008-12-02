class DukeController < ApplicationController
  before_filter :login_required
  
  def index
    @experiments = Experiment.find(:all, :conditions => [ 'assigned_to_id=? AND performed_on IS NULL', current_user ])
  end
end
