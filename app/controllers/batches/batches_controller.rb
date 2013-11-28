class Batches::BatchesController < ApplicationController
  
  # GET /batches/batches/new
  # GET /batches/batches/new.xml
  def new
    @batch = Batch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @batch }
    end
  end

  # POST /batches/batches
  # POST /batches/batches.xml
  def create
    @batch = Batch.new(params[:batch])

    respond_to do |format|
      if @batch.save
        flash[:notice] = 'Batch was successfully created.'
        format.html { redirect_to(@batch) }
        format.xml  { render :xml => @batch, :status => :created }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @batch.errors, :status => :unprocessable_entity }
      end
    end
  end

end
