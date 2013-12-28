class Batches::PhsController < ApplicationController
  
  # GET /batches/phs/new
  # GET /batches/phs/new.xml
  def edit
    if params[:id]
      @batch = Batch.find(params[:id])
    else
      flash[:notice] = 'You must select a batch ID!'
      redirect_to(non_ph_batches_preparations_path)
    end
  end

  # POST /batches/phs
  # POST /batches/phs.xml
  def update

    @batch = Batch.find(params[:id])

    if @batch.update_attributes(params[:batch])
      flash[:notice] = 'Batch was successfully updated.'
      redirect_to(no_experiment_batches_phs_path)
    else
      render :action => "new"
    end

  end

  def no_experiment
    
  end

end
