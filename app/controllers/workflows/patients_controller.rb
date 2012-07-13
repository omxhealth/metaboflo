class Workflows::PatientsController < ApplicationController
  # GET /workflows/patients.js
  def index
    respond_to do |format|
      format.json { 
        term = "#{params[:term]}%"
        @patients = TestSubject.where('id=? OR code LIKE ?', term.to_i, term).select('id, code')
        render :json => @patients.as_json(:methods => :to_label)
      }
    end
  end
  
  # GET /workflows/patients/new
  # GET /workflows/patients/new.js
  def new
    @test_subject = TestSubject.new
    
    respond_to do |format|
      format.html do
        if request.xhr?
          render :partial => 'form', :layout => false
        else
          render :new
        end
      end
    end
  end

  # POST /workflows/patients
  # POST /workflows/patients.js
  # POST /workflows/patients.xml
  def create
    @test_subject = TestSubject.new(params[:test_subject])

    respond_to do |format|
      if @test_subject.save
        format.html do
          if request.xhr?
            render :json => @test_subject.as_json(:methods => [ :to_label, :last_sample_id ]), :status => :created
          else
            flash[:notice] = "#{TestSubject.title} was successfully created."
            redirect_to(new_workflows_experiment_url)
          end
        end
      else
        format.html do
          if request.xhr?
            render :json => @test_subject.errors, :status => :unprocessable_entity
          else
            render :action => :new, :status => :unprocessable_entity
          end
        end
      end
    end
  end
end
