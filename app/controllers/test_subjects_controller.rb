class TestSubjectsController < ApplicationController
  VIEW_PATH = "test_subjects/subjects/#{SUBJECT_CONFIG[:name]}"
  
  before_filter :find_test_subject, :only => [ :tree, :show, :edit, :update, :destroy ]

  # GET /test_subjects
  def index
    @search = current_user.rank == 'Superuser' || current_user.rank == 'Administrator' ?
              TestSubject.search(params[:search]) :
              TestSubject.with_site(current_user.site).search(params[:search])
    @test_subjects = @search.includes(:samples, :site).all
    
    render :template => "#{VIEW_PATH}/index"
  end

  # GET /test_subjects/1
  def show
    @meals = @test_subject.meals

    render :template => "#{VIEW_PATH}/show"
  end

  # GET /test_subjects/new
  def new
    @test_subject = TestSubject.new
  end

  # GET /test_subjects/1/edit
  def edit
  end

  # POST /test_subjects
  def create
    @test_subject = TestSubject.new(params[:test_subject])

    if @test_subject.save
      flash[:notice] = "#{TestSubject.title} was successfully created."
      redirect_to(@test_subject)
    else
      render :action => "new"
    end
  end

  # PUT /test_subjects/1
  def update
    if @test_subject.update_attributes(params[:test_subject])
      flash[:notice] = "#{TestSubject.title} was successfully updated."
      redirect_to(@test_subject)
    else
      render :action => "edit"
    end
  end

  # DELETE /test_subjects/1
  def destroy
    @test_subject.destroy
    
    redirect_to(test_subjects_url)
  end

  # GET /test_subjects/1/tree.json
  def tree
    
  end

  protected
  def find_test_subject(param_name = :id)
    super
  end
end
