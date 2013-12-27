class Batches::PhsController < ApplicationController
  
  # GET /batches/phs/new
  # GET /batches/phs/new.xml
  def new
    @batch = Batch.find(params[:batch_id])
  end

  # POST /batches/phs
  # POST /batches/phs.xml
  def create

    respond_to do |format|
      if @batch.update_attributes(params[:batch])
        flash[:notice] = 'Batch was successfully updated.'
        redirect_to('/')
      else
        render :action => "new"
      end
    end

  end


end
