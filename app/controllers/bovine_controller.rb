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
  end
  
  def show_image
    # next 6 lines use R to plot a histogram
    @r = RSRuby.instance
    puts "R instance = #{@r.object_id}"
    @r.source("#{Rails.root}/lib/R/test.R")
    # then read the png file and deliver it to the browser
    @g = File.open("/tmp/plot.png", "rb") {|@f| @f.read}
    send_data @g, :type=>"image/png", :disposition=>'inline'
  end
  
end
