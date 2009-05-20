class TestSubjectEvaluationsController < ApplicationController
  before_filter :find_test_subject

  # GET /test_subject_evaluations
  # GET /test_subject_evaluations.xml
  def index
    @test_subject_evaluations = @test_subject.test_subject_evaluations.find(:all, :order => 'evaluated_on DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @test_subject_evaluations }
    end
  end

  # GET /test_subject_evaluations/1
  # GET /test_subject_evaluations/1.xml
  def show
    @test_subject_evaluation = @test_subject.test_subject_evaluations.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_subject_evaluation }
    end
  end

  # GET /test_subject_evaluations/new
  # GET /test_subject_evaluations/new.xml
  def new
    @test_subject_evaluation = TestSubjectEvaluation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_subject_evaluation }
    end
  end

  # GET /test_subject_evaluations/1/edit
  def edit
    @test_subject_evaluation = @test_subject.test_subject_evaluations.find(params[:id])
  end

  # POST /test_subject_evaluations
  # POST /test_subject_evaluations.xml
  def create
    @test_subject_evaluation = TestSubjectEvaluation.new(params[:test_subject_evaluation])

    @test_subject_evaluation.test_subject = @test_subject

    respond_to do |format|
      if @test_subject_evaluation.save
        flash[:notice] = 'Test Subject Evaluation was successfully created.'
        format.html { redirect_to(test_subject_test_subject_evaluation_url(@test_subject, @test_subject_evaluation)) }
        format.xml  { render :xml => @test_subject_evaluation, :status => :created, :location => @test_subject_evaluation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_subject_evaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_subject_evaluations/1
  # PUT /test_subject_evaluations/1.xml
  def update
    @test_subject_evaluation = @test_subject.test_subject_evaluations.find(params[:id])

    #Check if symptoms and past_medical is empty
    if !params.has_key?(:symptoms)
      @test_subject_evaluation.symptoms = []
    end
    if !params.has_key?(:past_medical)
      @test_subject_evaluation.past_medical = []
    end

    respond_to do |format|
      if @test_subject_evaluation.update_attributes(params[:test_subject_evaluation])
        flash[:notice] = 'Test Subject Evaluation was successfully updated.'
        format.html { redirect_to(test_subject_test_subject_evaluation_url(@test_subject, @test_subject_evaluation)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_subject_evaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_subject_evaluations/1
  # DELETE /test_subject_evaluations/1.xml
  def destroy
    @test_subject_evaluation = @test_subject.test_subject_evaluations.find(params[:id])
    @test_subject_evaluation.destroy

    respond_to do |format|
      format.html { redirect_to(test_subject_test_subject_evaluations_url(@test_subject)) }
      format.xml  { head :ok }
    end
  end
end
