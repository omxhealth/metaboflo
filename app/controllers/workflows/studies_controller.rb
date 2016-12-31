class Workflows::StudiesController < ApplicationController

  def new
    @study = Study.new
  end

  def create
    @study = Study.new(params[:study])
    if @study.save
      flash[:notice] = 'Study was successfully created.'
      redirect_to cohort_assignment_workflows_study_path(@study)
    else
      render action: 'new'
    end
  end

  def cohort_assignment
    @study = Study.where(id: params[:id]).includes(cohorts: [:test_subjects]).take!
    @assigned_test_subjects = @study.cohorts.collect { |cohort| cohort.test_subjects }.flatten.uniq
  end

  def add_to_cohort
    @study = Study.find(params[:id])
    @cohort = @study.cohorts.find(params[:cohort_id])
    @test_subject = TestSubject.find(params[:test_subject_id])

    @cohort.test_subjects << @test_subject

    respond_to do |format|
      format.js { render nothing: true, status: :ok }
    end
  end

  def remove_from_cohort
    @study = Study.find(params[:id])
    @cohort = @study.cohorts.find(params[:cohort_id])
    @test_subject = @cohort.test_subjects.find(params[:test_subject_id])

    @cohort.test_subjects.delete(@test_subject)

    respond_to do |format|
      format.js { render nothing: true, status: :ok }
    end
  end
end
