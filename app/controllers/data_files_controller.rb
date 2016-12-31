class DataFilesController < ApplicationController
  before_action :find_experiment

  # GET /data_files
  # GET /data_files.xml
  def index
    if @experiment
      @data_files = @experiment.data_files
    else
      all_data_files = DataFile.all

      if can_view_all(current_user)
        @data_files = all_data_files
      else
        @data_files = find_for_site(all_data_files, current_user.site)
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @data_files }
    end
  end

  # GET /data_files/1
  # GET /data_files/1.xml
  def show
    @data_file = @experiment.data_files.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @data_file }
    end
  end

  # GET /data_files/new
  # GET /data_files/new.xml
  def new
    @data_file = DataFile.new
    @data_file.experiment = @experiment

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @data_file }
    end
  end

  # POST /data_files
  # POST /data_files.xml
  def create
    @data_file = DataFile.new(params[:data_file])
    @data_file.experiment = @experiment

    respond_to do |format|
      if @data_file.save
        flash[:notice] = 'Data File was successfully uploaded.'
        format.html { redirect_to(experiment_data_file_path(@experiment, @data_file)) }
        format.xml  { render :xml => @data_file, :status => :created, :location => @data_file }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @data_file.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /data_files/1
  # DELETE /data_files/1.xml
  def destroy
    @data_file = @experiment.data_files.find(params[:id])
    @data_file.destroy

    respond_to do |format|
      format.html { redirect_to(experiment_data_files_path(@experiment)) }
      format.xml  { head :ok }
    end
  end

  private
  def find_experiment
    if params[:experiment_id]
      @experiment = Experiment.find(params[:experiment_id])
      @sample = @experiment.sample
      @test_subject = @sample.root
    end
  end

end
