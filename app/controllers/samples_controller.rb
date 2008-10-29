class SamplesController < ApplicationController
  before_filter :find_parent
  
  # GET /samples
  # GET /samples.xml
  def index
    if @parent_sample
      @samples = @parent_sample.samples
    elsif @patient
      @samples = @patient.samples
    else
      @samples = Sample.find(:all)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @samples }
    end
  end

  # GET /samples/1
  # GET /samples/1.xml
  def show
    @sample = Sample.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sample }
    end
  end

  # GET /samples/new
  # GET /samples/new.xml
  def new
    @sample = Sample.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sample }
    end
  end

  # GET /samples/1/edit
  def edit
    @sample = Sample.find(params[:id])
  end

  # POST /samples
  # POST /samples.xml
  def create
    @sample = Sample.new(params[:sample])
    if @parent_sample
      @sample.sample = @parent_sample
    else
      @sample.patient = @patient
    end
    
    respond_to do |format|
      if @sample.save
        flash[:notice] = 'Sample was successfully created.'
        format.html { redirect_to(patient_sample_url(@patient, @sample)) }
        format.xml  { render :xml => @sample, :status => :created, :location => @sample }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /samples/1
  # PUT /samples/1.xml
  def update
    @sample = Sample.find(params[:id])

    respond_to do |format|
      if @sample.update_attributes(params[:sample])
        flash[:notice] = 'Sample was successfully updated.'
        format.html { redirect_to(patient_sample_url(@patient, @sample)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sample.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /samples/1
  # DELETE /samples/1.xml
  def destroy
    @sample = Sample.find(params[:id])
    @sample.destroy

    respond_to do |format|
      format.html { redirect_to(@parent_sample ? sample_samples_url(@parent_sample) : patient_samples_url(@patient)) }
      format.xml  { head :ok }
    end
  end
  
  def find_parent
    if params[:patient_id]
      @patient = Patient.find(params[:patient_id])
    elsif params[:sample_id]
      @parent_sample = Sample.find(params[:sample_id])
      current_sample = @parent_sample
      while @patient.nil?
        @patient = current_sample.patient
        current_sample = current_sample.sample
      end
    elsif action_name != 'index'
      flash[:notice] = "Patient or parent sample must be specified."
      respond_to do |format|
        format.html { redirect_to samples_url }
        format.xml { redirect_to formatted_samples_url }
      end
    end
  end
end
