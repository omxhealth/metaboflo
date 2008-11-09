class CholesterolsController < ApplicationController
  before_filter :find_patient
  
  # GET /cholesterols
  # GET /cholesterols.xml
  def index
    @cholesterols = @patient.cholesterols.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cholesterols }
    end
  end

  # GET /cholesterols/1
  # GET /cholesterols/1.xml
  def show
    @cholesterol = @patient.cholesterols.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cholesterol }
    end
  end

  # GET /cholesterols/new
  # GET /cholesterols/new.xml
  def new
    @cholesterol = Cholesterol.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cholesterol }
    end
  end

  # GET /cholesterols/1/edit
  def edit
    @cholesterol = @patient.cholesterols.find(params[:id])
  end

  # POST /cholesterols
  # POST /cholesterols.xml
  def create
    @cholesterol = Cholesterol.new(params[:cholesterol])
    @cholesterol.patient = @patient
    
    respond_to do |format|
      if @cholesterol.save
        flash[:notice] = 'Cholesterol was successfully created.'
        format.html { redirect_to(patient_cholesterol_url(@patient, @cholesterol)) }
        format.xml  { render :xml => @cholesterol, :status => :created, :location => @cholesterol }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cholesterol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cholesterols/1
  # PUT /cholesterols/1.xml
  def update
    @cholesterol = @patient.cholesterols.find(params[:id])

    respond_to do |format|
      if @cholesterol.update_attributes(params[:cholesterol])
        flash[:notice] = 'Cholesterol was successfully updated.'
        format.html { redirect_to(patient_cholesterol_url(@patient, @cholesterol)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cholesterol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cholesterols/1
  # DELETE /cholesterols/1.xml
  def destroy
    @cholesterol = @patient.cholesterols.find(params[:id])
    @cholesterol.destroy

    respond_to do |format|
      format.html { redirect_to(patient_cholesterols_url(@patient)) }
      format.xml  { head :ok }
    end
  end
end
