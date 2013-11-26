class Batches::BatchesController < ApplicationController
  
  # GET /batches/samples/new
  # GET /batches/samples/new.xml
  def new
    @batch = Batch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @batch }
    end
  end

  def create

  end

end
