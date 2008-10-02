class DataFilesController < ApplicationController
  before_filter :find_sample

  # GET /data_files
  # GET /data_files.xml
  def index
    @data_files = @sample.data_files

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @data_files }
    end
  end

  # GET /data_files/1
  # GET /data_files/1.xml
  def show
    @data_file = @sample.data_files.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @data_file }
    end
  end

  # GET /data_files/new
  # GET /data_files/new.xml
  def new
    @data_file = DataFile.new
    @data_file.sample = @sample

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @data_file }
    end
  end

  # POST /data_files
  # POST /data_files.xml
  def create
    @data_file = DataFile.new(params[:data_file])
    @data_file.sample = @sample

    respond_to do |format|
      if @data_file.save
        flash[:notice] = 'Data File was successfully uploaded.'
        format.html { redirect_to(sample_data_file_path(@sample, @data_file)) }
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
    @data_file = @sample.data_files.find(params[:id])
    @data_file.destroy

    respond_to do |format|
      format.html { redirect_to(sample_data_files_path(@sample)) }
      format.xml  { head :ok }
    end
  end
  
  private 
  def find_sample
    @sample = Sample.find(params[:sample_id])
  end  
end
