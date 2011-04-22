class StudiesController < ApplicationController
  before_filter :load_cohorts

  def index
    @studies = Study.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @studies }
    end
  end
  
  def new
    @study = Study.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @study }
    end
  end
  
  def show
    @study = Study.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @study }
    end
  end

  def edit
    @study = Study.find(params[:id])
  end

  def create
    @study = Study.new(params[:study])

    respond_to do |format|
      if @study.save
        flash[:notice] = 'Study was successfully created.'
        format.html { redirect_to(@study) }
        format.xml  { render :xml => @study, :status => :created, :location => @study }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @study.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @study = Study.find(params[:id])

    respond_to do |format|
      if @study.update_attributes(params[:study])
        flash[:notice] = 'Study was successfully updated.'
        format.html { redirect_to(:action => 'show', :id => @study) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @study.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @study = Study.find(params[:id])
    @study.destroy

    respond_to do |format|
      flash[:notice] = 'Study was successfully deleted.'
      format.html { redirect_to(:action => 'index') }
      format.xml  { head :ok }
    end
  end  
  
  private 
  
  def load_cohorts
    Cohort #Required to load all Cohort types
  end
  
end
