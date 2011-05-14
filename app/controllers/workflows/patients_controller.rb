class Workflows::PatientsController < ApplicationController
  # GET /workflows/patients/new
  # GET /workflows/patients/new.xml
  def new
    @test_subject = TestSubject.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_subject }
    end
  end

  # POST /workflows/patients
  # POST /workflows/patients.xml
  def create
    @test_subject = TestSubject.new(params[:test_subject])
    @test_subject.samples << Sample.new

    respond_to do |format|
      if @test_subject.save
        flash[:notice] = "#{TestSubject.title} was successfully created."
        format.html { redirect_to(new_workflows_sample_experiment_url(@test_subject.samples.first)) }
        format.xml  { render :xml => @test_subject, :status => :created, :location => @test_subject }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_subject.errors, :status => :unprocessable_entity }
      end
    end
  end
end
