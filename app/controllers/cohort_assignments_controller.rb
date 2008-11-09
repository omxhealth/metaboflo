class CohortAssignmentsController < ApplicationController
  before_filter :find_patient
  
  # GET /cohort_assignments
  # GET /cohort_assignments.xml
  def index
    @cohort_assignments = @patient.cohort_assignments.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cohort_assignments }
    end
  end

  # GET /cohort_assignments/1
  # GET /cohort_assignments/1.xml
  def show
    @cohort_assignment = @patient.cohort_assignments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cohort_assignment }
    end
  end

  # GET /cohort_assignments/new
  # GET /cohort_assignments/new.xml
  def new
    @cohort_assignment = CohortAssignment.new
    @cohorts = Cohort.find(:all)
    @patient.cohorts.each do |c|
      @cohorts.delete(c)
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cohort_assignment }
    end
  end

  # GET /cohort_assignments/1/edit
  def edit
    @cohort_assignment = @patient.cohort_assignments.find(params[:id])
  end

  # POST /cohort_assignments
  # POST /cohort_assignments.xml
  def create
    @cohort_assignment = CohortAssignment.new(params[:cohort_assignment])
    @cohort_assignment.assignable = @patient

    respond_to do |format|
      if @cohort_assignment.save
        flash[:notice] = 'CohortAssignment was successfully created.'
        format.html { redirect_to(patient_cohort_assignment_url(@patient, @cohort_assignment)) }
        format.xml  { render :xml => @cohort_assignment, :status => :created, :location => @cohort_assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cohort_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cohort_assignments/1
  # PUT /cohort_assignments/1.xml
  def update
    @cohort_assignment = @patient.cohort_assignments.find(params[:id])

    respond_to do |format|
      if @cohort_assignment.update_attributes(params[:cohort_assignment])
        flash[:notice] = 'CohortAssignment was successfully updated.'
        format.html { redirect_to(patient_cohort_assignment_url(@patient, @cohort_assignment)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cohort_assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cohort_assignments/1
  # DELETE /cohort_assignments/1.xml
  def destroy
    @cohort_assignment = @patient.cohort_assignments.find(params[:id])
    @cohort_assignment.destroy

    respond_to do |format|
      format.html { redirect_to(patient_cohort_assignments_url(@patient)) }
      format.xml  { head :ok }
    end
  end
end
