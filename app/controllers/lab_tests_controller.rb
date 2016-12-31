class LabTestsController < ApplicationController
  before_action :find_test_subject

  # GET /lab_tests
  # GET /lab_tests.xml
  def index
    @lab_tests = @test_subject.lab_tests

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lab_tests }
    end
  end

  # GET /lab_tests/1
  # GET /lab_tests/1.xml
  def show
    @lab_test = @test_subject.lab_tests.find(params[:id])

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
    @lab_test = @test_subject.lab_tests.find(params[:id])
  end

  # POST /lab_tests
  # POST /lab_tests.xml
  def create
    @lab_test = LabTest.new(params[:lab_test])
    @lab_test.test_subject = @test_subject

    respond_to do |format|
      if @lab_test.save
        flash[:notice] = 'Lab Test was successfully created.'
        format.html { redirect_to(test_subject_lab_test_url(@test_subject, @lab_test)) }
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
    @lab_test = @test_subject.lab_tests.find(params[:id])

    respond_to do |format|
      if @lab_test.update_attributes(params[:lab_test])
        flash[:notice] = 'Lab Test was successfully updated.'
        format.html { redirect_to(test_subject_lab_test_url(@test_subject, @lab_test)) }
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
    @lab_test = @test_subject.lab_tests.find(params[:id])
    @lab_test.destroy

    respond_to do |format|
      format.html { redirect_to(test_subject_lab_tests_url(@test_subject)) }
      format.xml  { head :ok }
    end
  end
end
