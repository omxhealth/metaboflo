class AnimalEvaluationsController < ApplicationController
  before_filter :find_animal

  # GET /animal_evaluations
  # GET /animal_evaluations.xml
  def index
    @animal_evaluations = @animal.animal_evaluations.find(:all, :order => 'evaluated_on DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @animal_evaluations }
    end
  end

  # GET /animal_evaluations/1
  # GET /animal_evaluations/1.xml
  def show
    @animal_evaluation = @animal.animal_evaluations.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @animal_evaluation }
    end
  end

  # GET /animal_evaluations/new
  # GET /animal_evaluations/new.xml
  def new
    @animal_evaluation = AnimalEvaluation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @animal_evaluation }
    end
  end

  # GET /animal_evaluations/1/edit
  def edit
    @animal_evaluation = @animal.animal_evaluations.find(params[:id])
  end

  # POST /animal_evaluations
  # POST /animal_evaluations.xml
  def create
    @animal_evaluation = AnimalEvaluation.new(params[:animal_evaluation])

    @animal_evaluation.animal = @animal

    respond_to do |format|
      if @animal_evaluation.save
        flash[:notice] = 'AnimalEvaluation was successfully created.'
        format.html { redirect_to(animal_animal_evaluation_url(@animal, @animal_evaluation)) }
        format.xml  { render :xml => @animal_evaluation, :status => :created, :location => @animal_evaluation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @animal_evaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /animal_evaluations/1
  # PUT /animal_evaluations/1.xml
  def update
    @animal_evaluation = @animal.animal_evaluations.find(params[:id])

    #Check if symptoms and past_medical is empty
    if !params.has_key?(:symptoms)
      @animal_evaluation.symptoms = []
    end
    if !params.has_key?(:past_medical)
      @animal_evaluation.past_medical = []
    end

    respond_to do |format|
      if @animal_evaluation.update_attributes(params[:animal_evaluation])
        flash[:notice] = 'AnimalEvaluation was successfully updated.'
        format.html { redirect_to(animal_animal_evaluation_url(@animal, @animal_evaluation)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @animal_evaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /animal_evaluations/1
  # DELETE /animal_evaluations/1.xml
  def destroy
    @animal_evaluation = @animal.animal_evaluations.find(params[:id])
    @animal_evaluation.destroy

    respond_to do |format|
      format.html { redirect_to(animal_animal_evaluations_url(@animal)) }
      format.xml  { head :ok }
    end
  end
end
