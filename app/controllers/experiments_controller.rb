class ExperimentsController < ApplicationController
  before_filter :find_sample
  before_filter :find_experiment, :only => [ :show, :edit, :update, :destroy ]

  # GET /experiments
  # GET /experiments.xml
  def index
    if @sample
      @experiments = @sample.experiments
    else
      @experiments = Experiment.find(:all)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @experiments }
    end
  end

  # GET /experiments/1
  # GET /experiments/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @experiment }
    end
  end

  # GET /experiments/new
  # GET /experiments/new.xml
  def new
    @experiment = Experiment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @experiment }
    end
  end

  # GET /experiments/1/edit
  def edit
  end

  # POST /experiments
  # POST /experiments.xml
  def create
    @experiment = Experiment.new(params[:experiment])
    @experiment.sample = @sample

    respond_to do |format|
      if @experiment.save
        flash[:notice] = 'Experiment was successfully created.'
        format.html { redirect_to([@sample, @experiment]) }
        format.xml  { render :xml => @experiment, :status => :created, :location => @experiment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @experiment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /experiments/1
  # PUT /experiments/1.xml
  def update
    respond_to do |format|
      if @experiment.update_attributes(params[:experiment])
        flash[:notice] = 'Experiment was successfully updated.'
        format.html { redirect_to(@experiment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @experiment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /experiments/1
  # DELETE /experiments/1.xml
  def destroy
    @experiment.destroy

    respond_to do |format|
      format.html { redirect_to(experiments_url) }
      format.xml  { head :ok }
    end
  end

  private
  def find_sample
    if action_name != 'index' || !params[:sample_id].blank?
      @sample = Sample.find(params[:sample_id])
      params[:patient_id] = @sample.root.id
      find_patient
    end
  end

  def find_experiment
    @experiment = Experiment.find(params[:id])
    @sample = @experiment.sample
    current_sample = @sample
    while @patient.nil?
      @patient = current_sample.patient
      current_sample = current_sample.sample
    end
  end

end
