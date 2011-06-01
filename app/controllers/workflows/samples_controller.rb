class Workflows::SamplesController < ApplicationController
  before_filter :find_patient, :only => [:new, :create]
  
  # GET /workflows/samples.js
  def index
    @samples = Sample.joins(:test_subject).where(['code=?', params[:code]])
    
    respond_to do |format|
      format.js # index.js.erb
    end
  end
  
  # GET /workflows/patients/1/samples/new.js
  def new
    @sample = @patient.samples.new

    respond_to do |format|
      format.js # new.js.erb
    end
  end

  # POST /workflows/patients/1/samples.js
  def create
    @sample = @patient.samples.new(params[:sample])

    respond_to do |format|
      if @sample.save
        flash[:notice] = 'Sample was successfully created.'
        format.js # create.js.erb
      else
        format.js { render :action => "new" }
      end
    end
  end
  
  private
    def find_patient
      @patient = TestSubject.find(params[:patient_id])
    end
end
