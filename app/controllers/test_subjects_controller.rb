class TestSubjectsController < ApplicationController
  VIEW_PATH = "test_subjects/subjects/#{SUBJECT_CONFIG[:name]}"
  
  before_filter :find_test_subject, :only => [ :show, :edit, :update, :destroy ]

  # GET /test_subjects
  # GET /test_subjects.xml
  def index
    @search = TestSubject.search(params[:search])
    @test_subjects = current_user.rank == 'Superuser' || current_user.rank == 'Administrator' ?
                      @search.includes(:samples, :site).all :
                      @search.with_site(current_user.site).includes(:samples, :site).all

    respond_to do |format|
      format.html { render :template => "#{VIEW_PATH}/index" }
      format.xml  { render :xml => @test_subjects }
    end
  end

  # GET /test_subjects/1
  # GET /test_subjects/1.xml
  def show

    # @tree = test_subject_tree(@test_subject)

    @meals = @test_subject.meals

    respond_to do |format|
      format.html { render :template => "#{VIEW_PATH}/show" }
      format.xml  { render :xml => @test_subject }
    end
  end

  # GET /test_subjects/new
  # GET /test_subjects/new.xml
  def new
    @test_subject = TestSubject.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @test_subject }
    end
  end

  # GET /test_subjects/1/edit
  def edit
  end

  # POST /test_subjects
  # POST /test_subjects.xml
  def create
    @test_subject = TestSubject.new(params[:test_subject])

    respond_to do |format|
      if @test_subject.save
        flash[:notice] = "#{TestSubject.title} was successfully created."
        format.html { redirect_to(@test_subject) }
        format.xml  { render :xml => @test_subject, :status => :created, :location => @test_subject }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @test_subject.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_subjects/1
  # PUT /test_subjects/1.xml
  def update
    respond_to do |format|
      if @test_subject.update_attributes(params[:test_subject])
        flash[:notice] = "#{TestSubject.title} was successfully updated."
        format.html { redirect_to(@test_subject) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @test_subject.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_subjects/1
  # DELETE /test_subjects/1.xml
  def destroy
    @test_subject.destroy

    respond_to do |format|
      format.html { redirect_to(test_subjects_url) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_test_subject(param_name = :id)
    super
  end
end
