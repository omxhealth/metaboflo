class BovineController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @experiments = Experiment.find(:all, :conditions => [ 'assigned_to_id=? AND performed_on IS NULL', current_user ])

    #Find the user's incomplete tasks:
    @incomplete_tasks = []
    current_user.tasks.each do |task|
      if task.done_ratio < 100
        @incomplete_tasks << task
      end
    end
    
    #Get system statistics:
    @stats = []
    @stats << ["Number of Users", User.count]
    @stats << ["Number of #{TestSubject.title.pluralize}", TestSubject.count]
    @stats << ["Number of Samples", Sample.count]
    @stats << ["Number of Experiments", Experiment.count]
    @stats << ["Number of Metabolite Concentrations", Concentration.count]
    @stats << ["Number of Tasks", Task.count]
    @stats << ["Number of Unfinished Tasks", Task.find(:all, :conditions => ['done_ratio<100']).count]
    
  end
end
