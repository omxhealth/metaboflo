class ExperimentsController < ApplicationController
  before_action :find_sample
  before_action :find_test_subject, only: [ :index ]
  before_action :find_experiment, only: [ :show, :edit, :update, :destroy ]

  # GET /experiments
  # GET /experiments.xml
  def index
    if @sample
      @experiments = @sample.experiments
    elsif @test_subject
      @experiments = @test_subject.experiments
    else
      @experiments = Experiment.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render xml: @experiments }
    end
  end

  # GET /experiments/1
  # GET /experiments/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render xml: @experiment }
    end
  end

  # GET /experiments/new
  # GET /experiments/new.xml
  def new
    @experiment = Experiment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @experiment }
    end
  end

  # GET /experiments/1/edit
  def edit
  end

  # POST /experiments
  # POST /experiments.xml
  def create
    @experiment = Experiment.new(experiment_params)
    @experiment.sample = @sample

    respond_to do |format|
      if @experiment.save
        format.html { redirect_to [@sample, @experiment], notice: 'Experiment was successfully created.' }
        format.xml  { render xml: @experiment, status: :created, location: @experiment }
      else
        format.html { render action: "new" }
        format.xml  { render xml: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /experiments/1
  # PUT /experiments/1.xml
  def update
    respond_to do |format|
      if @experiment.update(experiment_params)
        format.html { redirect_to [@sample, @experiment], notice: 'Experiment was successfully updated.' }
        format.xml  { head :ok }
      else
        format.html { render action: "edit" }
        format.xml  { render xml: @experiment.errors, status: :unprocessable_entity }
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
      params[:test_subject_id] = @sample.root.id
      find_test_subject
    end
  end

  def find_test_subject
    super unless params[:test_subject_id].nil?
  end

  def find_experiment
    @experiment = Experiment.find(params[:id])
    @sample = @experiment.sample
    current_sample = @sample
    @test_subject = current_sample.root
  end

  def experiment_params
    params.require(:experiment).permit!
  end
end
