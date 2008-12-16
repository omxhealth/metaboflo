class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.xml
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @tasks = @user.tasks
    else
      @tasks = Task.find(:all)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new(:done_ratio => 0)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        format.html { redirect_to(@task) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /tasks/gantt
  def gantt
    @gantt = Jrc::Helpers::Gantt.new(params)

    # Tasks that have start and due dates
    conditions = "(((start_date >= ? AND start_date <= ?) OR (due_date >= ? AND due_date <= ?) OR (start_date < ? AND due_date > ?)) "
    conditions << "AND start_date IS NOT NULL AND due_date IS NOT NULL)"
    
    from = @gantt.date_from
    to = @gantt.date_to
    
    @gantt.events = Task.find( :all, :order => 'start_date, due_date', :conditions => [conditions, from, to, from, to, from, to] )

    respond_to do |format|
      format.html { }
      format.js { render :template => 'tasks/gantt', :layout => false }
    end
  end

  # GET /tasks/calendar
  def calendar
    if params[:year] and params[:year].to_i > 1900
      @year = params[:year].to_i
      if params[:month] and params[:month].to_i > 0 and params[:month].to_i < 13
        @month = params[:month].to_i
      end    
    end

    @year ||= Date.today.year
    @month ||= Date.today.month

    @calendar = Jrc::Helpers::Calendar.new(Date.civil(@year, @month, 1), :month)

    from = @calendar.startdt
    to = @calendar.enddt

    @calendar.events = Task.find( :all, :conditions => ["(start_date BETWEEN ? AND ?) OR (due_date BETWEEN ? AND ?)", from, to, from, to] )
    
    respond_to do |format|
      format.html { }
      format.js { render :template => 'tasks/calendar', :layout => false }
    end
    
  end

end
