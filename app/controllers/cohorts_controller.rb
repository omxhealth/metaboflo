class CohortsController < ApplicationController
  # GET /cohorts
  # GET /cohorts.xml
  def index
    @cohorts = Cohort.find(:all)

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
    @cohort = Cohort.new(params[:cohort])

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
        format.html { redirect_to(@cohort) }
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
      format.html { redirect_to(cohorts_url) }
      format.xml  { head :ok }
    end
  end
end
