class LabTestsController < ApplicationController
  before_filter :find_animal
  
  # GET /lab_tests
  # GET /lab_tests.xml
  def index
    @lab_tests = @animal.lab_tests
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lab_tests }
    end
  end

  # GET /lab_tests/1
  # GET /lab_tests/1.xml
  def show
    @lab_test = @animal.lab_tests.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lab_test }
    end
  end

  # GET /lab_tests/new
  # GET /lab_tests/new.xml
  def new
    @lab_test = LabTest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lab_test }
    end
  end

  # GET /lab_tests/1/edit
  def edit
    @lab_test = @animal.lab_tests.find(params[:id])
  end

  # POST /lab_tests
  # POST /lab_tests.xml
  def create
    @lab_test = LabTest.new(params[:lab_test])
    @lab_test.animal = @animal

    respond_to do |format|
      if @lab_test.save
        flash[:notice] = 'Lab Test was successfully created.'
        format.html { redirect_to(animal_lab_test_url(@animal, @lab_test)) }
        format.xml  { render :xml => @lab_test, :status => :created, :location => @lab_test }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lab_test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lab_tests/1
  # PUT /lab_tests/1.xml
  def update
    @lab_test = @animal.lab_tests.find(params[:id])

    respond_to do |format|
      if @lab_test.update_attributes(params[:lab_test])
        flash[:notice] = 'Lab Test was successfully updated.'
        format.html { redirect_to(animal_lab_test_url(@animal, @lab_test)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lab_test.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lab_tests/1
  # DELETE /lab_tests/1.xml
  def destroy
    @lab_test = @animal.lab_tests.find(params[:id])
    @lab_test.destroy

    respond_to do |format|
      format.html { redirect_to(animal_lab_tests_url(@animal)) }
      format.xml  { head :ok }
    end
  end
end
