class CreatininesController < ApplicationController
  before_filter :login_required
  before_filter :find_patient
  
  # GET /creatinines
  # GET /creatinines.xml
  def index
    @creatinines = @patient.creatinines.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @creatinines }
    end
  end

  # GET /creatinines/1
  # GET /creatinines/1.xml
  def show
    @creatinine = @patient.creatinines.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @creatinine }
    end
  end

  # GET /creatinines/new
  # GET /creatinines/new.xml
  def new
    @creatinine = Creatinine.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @creatinine }
    end
  end

  # GET /creatinines/1/edit
  def edit
    @creatinine = @patient.creatinines.find(params[:id])
  end

  # POST /creatinines
  # POST /creatinines.xml
  def create
    @creatinine = Creatinine.new(params[:creatinine])
    @creatinine.patient = @patient
    
    respond_to do |format|
      if @creatinine.save
        flash[:notice] = 'Creatinine was successfully created.'
        format.html { redirect_to(patient_creatinine_url(@patient, @creatinine)) }
        format.xml  { render :xml => @creatinine, :status => :created, :location => @creatinine }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @creatinine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /creatinines/1
  # PUT /creatinines/1.xml
  def update
    @creatinine = @patient.creatinines.find(params[:id])

    respond_to do |format|
      if @creatinine.update_attributes(params[:creatinine])
        flash[:notice] = 'Creatinine was successfully updated.'
        format.html { redirect_to(patient_creatinine_url(@patient, @creatinine)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @creatinine.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /creatinines/1
  # DELETE /creatinines/1.xml
  def destroy
    @creatinine = @patient.creatinines.find(params[:id])
    @creatinine.destroy

    respond_to do |format|
      format.html { redirect_to(patient_creatinines_url(@patient)) }
      format.xml  { head :ok }
    end
  end
end
