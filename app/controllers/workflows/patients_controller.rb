class Workflows::PatientsController < ApplicationController
  # GET /workflows/patients.js
  def index
    @test_subjects = TestSubject.where(['id=? OR lower(code) LIKE ?', params[:q].to_i, "%#{params[:q].to_s.downcase}%"])
    
    respond_to do |format|
      format.js # index.js.erb
    end
  end
  
  # GET /workflows/patients/new
  # GET /workflows/patients/new.js
  # GET /workflows/patients/new.xml
  def new
    @test_subject = TestSubject.new

    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
      format.xml  { render :xml => @test_subject }
    end
  end

  # POST /workflows/patients
  # POST /workflows/patients.js
  # POST /workflows/patients.xml
  def create
    @test_subject = TestSubject.new(params[:test_subject])

    respond_to do |format|
      if @test_subject.save
        flash[:notice] = "#{TestSubject.title} was successfully created."
        format.html { redirect_to(new_workflows_experiment_url) }
        format.js # create.js.erb
        format.xml  { render :xml => @test_subject, :status => :created, :location => @test_subject }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new" }
        format.xml  { render :xml => @test_subject.errors, :status => :unprocessable_entity }
      end
    end
  end
end
