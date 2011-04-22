class CohortsController < ApplicationController
  before_filter :find_type

  # GET /cohorts
  # GET /cohorts.xml
  def index
    @cohorts = "#{@type}Cohort".constantize.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cohorts }
    end
  end

  # GET /cohorts/1
  # GET /cohorts/1.xml
  def show
    @cohort = Cohort.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cohort }
    end
  end

  # GET /cohorts/new
  # GET /cohorts/new.xml
  def new
    @cohort = Cohort.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cohort }
    end
  end

  # GET /cohorts/1/edit
  def edit
    @cohort = Cohort.find(params[:id])
  end

  # POST /cohorts
  # POST /cohorts.xml
  def create
    @cohort = Cohort.factory(@type, params[:cohort])

    respond_to do |format|
      if @cohort.save
        flash[:notice] = 'Cohort was successfully created.'
        format.html { redirect_to(@cohort) }
        format.xml  { render :xml => @cohort, :status => :created, :location => @cohort }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cohort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cohorts/1
  # PUT /cohorts/1.xml
  def update
    @cohort = Cohort.find(params[:id])

    respond_to do |format|
      if @cohort.update_attributes(params[:cohort])
        flash[:notice] = 'Cohort was successfully updated.'
        format.html { redirect_to(:action => 'show', :type => @type, :id => @cohort) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cohort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cohorts/1
  # DELETE /cohorts/1.xml
  def destroy
    @cohort = Cohort.find(params[:id])
    @cohort.destroy

    respond_to do |format|
      flash[:notice] = 'Cohort was successfully deleted.'
      format.html { redirect_to(:action => 'index', :type => @type) }
      format.xml  { head :ok }
    end
  end

  private 
  def find_type
    Cohort #Required to load all Cohort types
    @type = params[:type]
  end

end
