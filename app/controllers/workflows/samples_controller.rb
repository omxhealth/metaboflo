class Workflows::SamplesController < ApplicationController
  before_action :find_patient, :only => [:new]

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
      format.html do
        if request.xhr?
          render :partial => 'form', :layout => false
        else
          render :new
        end
      end
    end
  end

  # POST /workflows/samples
  def create
    @sample = Sample.new(params[:sample])

    respond_to do |format|
      if @sample.save
        format.html do
          if request.xhr?
            render :json => @sample.as_json(:methods => :to_label), :status => :created
          end
        end
      else
        format.html do
          if request.xhr?
            render :json => @sample.errors, :status => :unprocessable_entity
          end
        end
      end
    end
  end

  # GET /workflows/samples/1
  def show
    @sample = Sample.find(params[:id])
    respond_to do |format|
      format.html do
        if request.xhr?
          render :partial => 'sample', :layout => false
        end
      end
    end
  end

  # POST /workflows/patients/1/samples.js
  def create_old
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
