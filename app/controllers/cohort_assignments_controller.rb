class CohortAssignmentsController < ApplicationController
  before_filter :find_cohort
  before_filter :find_assignable
  
  # GET /cohort_assignments
  # GET /cohort_assignments.xml
  def index
    @cohort_assignments = @entity.cohort_assignments.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cohort_assignments }
    end
  end

  # GET /cohort_assignments/1
  # GET /cohort_assignments/1.xml
  def show
    @cohort_assignment = @entity.cohort_assignments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cohort_assignment }
    end
  end

  # GET /cohort_assignments/new
  # GET /cohort_assignments/new.xml
  def new
    @cohort_assignment = CohortAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cohort_assignment }
    end
  end

  # POST /cohort_assignments
  # POST /cohort_assignments.xml
  def create
    @cohort_assignment = CohortAssignment.new(params[:cohort_assignment])
    
    if @entity.is_a?(Cohort)
      @cohort_assignment.cohort = @entity
    else
      @cohort_assignment.assignable = @entity
    end

    respond_to do |format|
      if @cohort_assignment.save
        format.html { 
          flash[:notice] = "#{@cohort_assignment.assignable.class} was successfully added to the cohort."
          redirect_to(:controller => @assignable_type.tableize, :action => 'show', :id => @assignable) 
        }
        format.js { @successful = true } # Render create.js.erb
        format.xml  { render :xml => @cohort_assignment, :status => :created, :location => @cohort_assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cohort_assignment.errors, :status => :unprocessable_cohort }
        format.js { @successful = false } # Render create.js.erb
      end
    end
  end

  # DELETE /cohort_assignments/1
  # DELETE /cohort_assignments/1.xml
  def destroy
    @cohort_assignment = @entity.cohort_assignments.find(params[:id])
    @cohort_assignment.destroy

    respond_to do |format|
      format.html { 
        flash[:notice] = "#{@cohort_assignment.assignable.class} was successfully removed from the cohort."
        redirect_to(:controller => @assignable_type.tableize, :action => 'show', :id => @assignable)   
      }
      format.js { @successful = true } # Render destroy.js.erb
      format.xml  { head :ok }
    end
  end

  private
  def find_cohort
    @entity = @cohort = Cohort.find(params[:cohort_id]) if params[:cohort_id]
  end

  def find_assignable
    Cohort.valid_types.each do |assignable_type|
      if !params["#{assignable_type.tableize.singularize}_id"].blank?
        @assignable_type = assignable_type
        @entity = @assignable = assignable_type.constantize.find(params["#{assignable_type.tableize.singularize}_id"])
        @test_subject = @entity if @entity.class == TestSubject
      end
    end
  end


end
