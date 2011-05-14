class SamplesController < ApplicationController
  before_filter :find_test_subject
  before_filter :find_parent_sample
  before_filter :find_sample, :only => [ :show, :edit, :update, :destroy ]
  before_filter :no_parent?, :only => [ :new, :create ]
  
  # GET /samples
  # GET /samples.xml
  def index
    @search = Sample.search(params[:search])
  
    if @parent.blank?
      @all_samples = @search.includes(:sample, :test_subject, :experiments => [ :experiment_type ]).all
      if can_view_all(current_user)
        @samples = @all_samples
      else
        @samples = find_for_site(@all_samples.all, current_user.site)
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
    if @parent.kind_of?(TestSubject)
      @sample.test_subject = @parent
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

    flash[:notice] = 'Sample was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to(@parent.kind_of?(Sample) ? sample_samples_url(@parent) : test_subject_samples_url(@test_subject)) }
      format.xml  { head :ok }
    end
  end
  
  protected
    def find_test_subject
      unless params[:test_subject_id].blank?
        super
        @parent = @test_subject if @parent.blank?
      end
    end
    
    def find_parent_sample
      unless params[:sample_id].blank?
        @parent = @parent_sample = Sample.find(params[:sample_id])
        params[:test_subject_id] = @parent.root.id
        find_test_subject
      end
    end
    
    def find_sample
      @sample = @parent.blank? ? Sample.find(params[:id]) : @parent.samples.find(params[:id])
      params[:test_subject_id] = @sample.root.id
      find_test_subject
    end
    
    def no_parent?
      redirect_to samples_url if @parent.blank?
    end
end
