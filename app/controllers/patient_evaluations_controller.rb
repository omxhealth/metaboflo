class PatientEvaluationsController < ApplicationController
  before_filter :find_patient

  # GET /patient_evaluations
  # GET /patient_evaluations.xml
  def index
    @patient_evaluations = @patient.patient_evaluations.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @patient_evaluations }
    end
  end

  # GET /patient_evaluations/1
  # GET /patient_evaluations/1.xml
  def show
    @patient_evaluation = @patient.patient_evaluations.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patient_evaluation }
    end
  end

  # GET /patient_evaluations/new
  # GET /patient_evaluations/new.xml
  def new
    @patient_evaluation = PatientEvaluation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patient_evaluation }
    end
  end

  # GET /patient_evaluations/1/edit
  def edit
    @patient_evaluation = @patient.patient_evaluations.find(params[:id])
  end

  # POST /patient_evaluations
  # POST /patient_evaluations.xml
  def create
    @patient_evaluation = PatientEvaluation.new(params[:patient_evaluation])

    @patient_evaluation.patient = @patient

    respond_to do |format|
      if @patient_evaluation.save
        flash[:notice] = 'PatientEvaluation was successfully created.'
        format.html { redirect_to(patient_patient_evaluation_url(@patient, @patient_evaluation)) }
        format.xml  { render :xml => @patient_evaluation, :status => :created, :location => @patient_evaluation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patient_evaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patient_evaluations/1
  # PUT /patient_evaluations/1.xml
  def update
    @patient_evaluation = @patient.patient_evaluations.find(params[:id])

    respond_to do |format|
      if @patient_evaluation.update_attributes(params[:patient_evaluation])
        flash[:notice] = 'PatientEvaluation was successfully updated.'
        format.html { redirect_to(patient_patient_evaluation_url(@patient, @patient_evaluation)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patient_evaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patient_evaluations/1
  # DELETE /patient_evaluations/1.xml
  def destroy
    @patient_evaluation = @patient.patient_evaluations.find(params[:id])
    @patient_evaluation.destroy

    respond_to do |format|
      format.html { redirect_to(patient_patient_evaluations_url(@patient)) }
      format.xml  { head :ok }
    end
  end
end
