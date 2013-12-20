class Batches::PhsController < ApplicationController
  
  # GET /batches/phs/new
  # GET /batches/phs/new.xml
  def new
    @batch = Batch.find(params[:batch_id])
  end

  # POST /batches/phs
  # POST /batches/phs.xml
  def create


  end


end
