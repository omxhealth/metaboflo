class StudyCohortAssignmentsController < ApplicationController
  before_filter :find_cohort
  before_filter :find_assignable
  
  # GET /study_cohort_assignments
  # GET /study_cohort_assignments.xml
  def index
    @study_cohort_assignments = @entity.cohort_assignments.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @study_cohort_assignments }
    end
  end

  # GET /study_cohort_assignments/1
  # GET /study_cohort_assignments/1.xml
  def show
    @study_cohort_assignment = @entity.cohort_assignments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @study_cohort_assignment }
    end
  end

  # GET /study_cohort_assignments/new
  # GET /study_cohort_assignments/new.xml
  def new
    @study_cohort_assignment = StudyCohortAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @study_cohort_assignment }
    end
  end

  # POST /study_cohort_assignments
  # POST /study_cohort_assignments.xml
  def create
    @study_cohort_assignment = StudyCohortAssignment.new(params[:study_cohort_assignment])
    
    if @entity.is_a?(Cohort)
      @study_cohort_assignment.cohort = @entity
    else
      @study_cohort_assignment.assignable = @entity
    end

    respond_to do |format|
      if @study_cohort_assignment.save
        format.html { 
          flash[:notice] = "#{@study_cohort_assignment.assignable.class} was successfully added to the study."
          redirect_to(:controller => @assignable_type.tableize, :action => 'show', :id => @assignable) 
        }
        format.js { @successful = true } # Render create.js.erb 
        format.xml  { render :xml => @study_cohort_assignment, :status => :created, :location => @study_cohort_assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @study_cohort_assignment.errors, :status => :unprocessable_cohort }
        format.js { @successful = false } # Render create.js.erb 
      end
    end
  end

  # DELETE /study_cohort_assignments/1
  # DELETE /study_cohort_assignments/1.xml
  def destroy
    @study_cohort_assignment = @entity.cohort_assignments.find(params[:id])
    @study_cohort_assignment.destroy

    respond_to do |format|
      format.html { 
        flash[:notice] = "#{@study_cohort_assignment.assignable.class} was successfully removed from the study."
        redirect_to(:controller => @assignable_type.tableize, :action => 'show', :id => @assignable)   
      }
      format.js { @successful = true } # Render create.rjs 
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
