class SamplesController < ApplicationController
  before_filter :find_patient
  before_filter :find_parent_sample
  before_filter :find_sample, :only => [ :show, :edit, :update, :destroy ]
  before_filter :no_parent?, :only => [ :new, :create ]
  
  # GET /samples
  # GET /samples.xml
  def index
    if @parent.blank?
      @all_samples = Sample.find(:all)
      if current_user.rank == 'Superuser' || current_user.rank == 'Administrator'
        @samples = @all_samples
      else
        # remove samples where root patient is from another site
        #TODO *** IS THERE A BETTER WAY TO IMPLEMENT THIS??? ***
        @samples = []
        @all_samples.each do |s|
          @samples << s if s.root.site == current_user.site
        end
      end
    else
      @samples = @parent.samples
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @samples }
    end
  end

  # GET /samples/1
  # GET /samples/1.xml
  def show
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
  end

  # POST /samples
  # POST /samples.xml
  def create
    @sample = Sample.new(params[:sample])
    if @parent.kind_of?(Patient)
      @sample.patient = @parent
    else
      @sample.sample = @parent
    end
    
    respond_to do |format|
      if @sample.save
        flash[:notice] = 'Sample was successfully created.'
        format.html { redirect_to([@parent, @sample]) }
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
    respond_to do |format|
      if @sample.update_attributes(params[:sample])
        flash[:notice] = 'Sample was successfully updated.'
        format.html { redirect_to([@parent, @sample]) }
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
    @sample.destroy

    respond_to do |format|
      format.html { redirect_to(@parent.kind_of?(Sample) ? sample_samples_url(@parent) : patient_samples_url(@patient)) }
      format.xml  { head :ok }
    end
  end
  
  protected
    def find_patient
      unless params[:patient_id].blank?
        super
        @parent = @patient if @parent.blank?
      end
    end
    
    def find_parent_sample
      unless params[:sample_id].blank?
        @parent = Sample.find(params[:sample_id])
        params[:patient_id] = @parent.root.id
        find_patient
      end
    end
    
    def find_sample
      @sample = @parent.blank? ? Sample.find(params[:id]) : @parent.samples.find(params[:id])
      params[:patient_id] = @sample.root.id
      find_patient
    end
    
    def no_parent?
      redirect_to samples_url if @parent.blank?
    end
end
