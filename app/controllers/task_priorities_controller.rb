class TaskPrioritiesController < ApplicationController
  # GET /task_priorities
  # GET /task_priorities.xml
  def index
    @task_priorities = TaskPriority.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @task_priorities }
    end
  end

  # GET /task_priorities/1
  # GET /task_priorities/1.xml
  def show
    @task_priority = TaskPriority.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task_priority }
    end
  end

  # GET /task_priorities/new
  # GET /task_priorities/new.xml
  def new
    @task_priority = TaskPriority.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task_priority }
    end
  end

  # GET /task_priorities/1/edit
  def edit
    @task_priority = TaskPriority.find(params[:id])
  end

  # POST /task_priorities
  # POST /task_priorities.xml
  def create
    @task_priority = TaskPriority.new(params[:task_priority])

    respond_to do |format|
      if @task_priority.save
        flash[:notice] = 'TaskPriority was successfully created.'
        format.html { redirect_to(@task_priority) }
        format.xml  { render :xml => @task_priority, :status => :created, :location => @task_priority }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task_priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /task_priorities/1
  # PUT /task_priorities/1.xml
  def update
    @task_priority = TaskPriority.find(params[:id])

    respond_to do |format|
      if @task_priority.update_attributes(params[:task_priority])
        flash[:notice] = 'TaskPriority was successfully updated.'
        format.html { redirect_to(@task_priority) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task_priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /task_priorities/1
  # DELETE /task_priorities/1.xml
  def destroy
    @task_priority = TaskPriority.find(params[:id])
    @task_priority.destroy

    respond_to do |format|
      format.html { redirect_to(task_priorities_url) }
      format.xml  { head :ok }
    end
  end
end
