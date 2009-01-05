class DataFileTypesController < ApplicationController
  before_filter :only_user?, :only => [ :new, :create, :edit, :update ]
  before_filter :administrator?, :only => [ :destroy ]
  
  # GET /data_file_types
  # GET /data_file_types.xml
  def index
    @data_file_types = DataFileType.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @data_file_types }
    end
  end

  # GET /data_file_types/1
  # GET /data_file_types/1.xml
  def show
    @data_file_type = DataFileType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @data_file_type }
    end
  end

  # GET /data_file_types/new
  # GET /data_file_types/new.xml
  def new
    @data_file_type = DataFileType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @data_file_type }
    end
  end

  # GET /data_file_types/1/edit
  def edit
    @data_file_type = DataFileType.find(params[:id])
  end

  # POST /data_file_types
  # POST /data_file_types.xml
  def create
    @data_file_type = DataFileType.new(params[:data_file_type])

    respond_to do |format|
      if @data_file_type.save
        flash[:notice] = 'DataFileType was successfully created.'
        format.html { redirect_to(@data_file_type) }
        format.xml  { render :xml => @data_file_type, :status => :created, :location => @data_file_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @data_file_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /data_file_types/1
  # PUT /data_file_types/1.xml
  def update
    @data_file_type = DataFileType.find(params[:id])

    respond_to do |format|
      if @data_file_type.update_attributes(params[:data_file_type])
        flash[:notice] = 'Data file type was successfully updated.'
        format.html { redirect_to(@data_file_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @data_file_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /data_file_types/1
  # DELETE /data_file_types/1.xml
  def destroy
    @data_file_type = DataFileType.find(params[:id])
    @data_file_type.destroy

    respond_to do |format|
      format.html { redirect_to(data_file_types_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
    def only_user?(redirect_path = data_file_types_path)
      super
    end
    
    def administrator?(redirect_path = data_file_types_path)
      super
    end
end
