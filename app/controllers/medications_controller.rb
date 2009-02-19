class MedicationsController < ApplicationController
  before_filter :find_animal

  # GET /medications
  # GET /medications.xml
  def index
    @medications = @animal.medications.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @medications }
    end
  end

  # GET /medications/1
  # GET /medications/1.xml
  def show
    @medication = @animal.medications.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @medication }
    end
  end

  # GET /medications/new
  # GET /medications/new.xml
  def new
    @medication = Medication.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @medication }
    end
  end

  # GET /medications/1/edit
  def edit
    @medication = @animal.medications.find(params[:id])
  end

  # POST /medications
  # POST /medications.xml
  def create
    @medication = Medication.new(params[:medication])
    @medication.animal = @animal
    
    respond_to do |format|
      if @medication.save
        flash[:notice] = 'Medication was successfully created.'
        format.html { redirect_to(animal_medication_url(@animal, @medication)) }
        format.xml  { render :xml => @medication, :status => :created, :location => @medication }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @medication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /medications/1
  # PUT /medications/1.xml
  def update
    @medication = @animal.medications.find(params[:id])

    respond_to do |format|
      if @medication.update_attributes(params[:medication])
        flash[:notice] = 'Medication was successfully updated.'
        format.html { redirect_to(animal_medication_url(@animal, @medication)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @medication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /medications/1
  # DELETE /medications/1.xml
  def destroy
    @medication = @animal.medications.find(params[:id])
    @medication.destroy

    respond_to do |format|
      format.html { redirect_to(animal_medications_url(@animal)) }
      format.xml  { head :ok }
    end
  end

end
