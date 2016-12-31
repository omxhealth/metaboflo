class GroupingAssignmentsController < ApplicationController
  before_action :find_grouping
  before_action :find_assignable

  # GET /grouping_assignments
  def index
    @grouping_assignments = @entity.grouping_assignments.all
  end

  # GET /grouping_assignments/1
  def show
    @grouping_assignment = @entity.grouping_assignments.find(params[:id])
  end

  # GET /grouping_assignments/new
  def new
    @grouping_assignment = GroupingAssignment.new
  end

  # POST /grouping_assignments
  def create
    @grouping_assignment = GroupingAssignment.new(grouping_assignment_params)

    if @entity.is_a?(Grouping)
      @grouping_assignment.grouping = @entity
    else
      @grouping_assignment.assignable = @entity
    end

    respond_to do |format|
      if @grouping_assignment.save
        format.html {
          flash[:notice] = "#{@grouping_assignment.assignable.class} was successfully added to the group."
          redirect_to(controller: @assignable_type.tableize, action: 'show', id: @assignable)
        }
        format.js { @successful = true } # Render create.js.erb
      else
        format.html { render action: "new" }
        format.js { @successful = false } # Render create.js.erb
      end
    end
  end

  # DELETE /grouping_assignments/1
  def destroy
    @grouping_assignment = @entity.grouping_assignments.find(params[:id])
    @grouping_assignment.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = "#{@grouping_assignment.assignable.class} was successfully removed from the group."
        redirect_to(controller: @assignable_type.tableize, action: 'show', id: @assignable)
      }
      format.js { @successful = true } # Render destroy.js.erb
    end
  end

  private

  def find_grouping
    @entity = @grouping = Grouping.find(params[:grouping_id]) if params[:grouping_id]
  end

  def find_assignable
    Grouping.valid_types.each do |assignable_type|
      if !params["#{assignable_type.tableize.singularize}_id"].blank?
        @assignable_type = assignable_type
        @entity = @assignable = assignable_type.constantize.find(params["#{assignable_type.tableize.singularize}_id"])
        @test_subject = @entity if @entity.class == TestSubject
      end
    end
  end

  def grouping_assignment_params
    params.require(:grouping_assignment).permit!
  end
end
