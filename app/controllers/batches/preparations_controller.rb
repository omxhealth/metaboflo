class Batches::PreparationsController < ApplicationController
  
  # GET /batches/preparations/new
  # GET /batches/preparations/new.xml
  def new
    if (params[:samples])
      @samples = Sample.find(params[:samples])
    else
      @samples = Array.new
    end
  end

  # POST /batches/preparations
  # POST /batches/preparations.xml
  def create
    @batch = Batch.new(params[:batch])

    puts params

    # respond_to do |format|
    #   if @batch.save
    #     flash[:notice] = 'Batch was successfully created.'
    #     format.html { redirect_to(unprepped_batches_batches_path) }
    #     format.xml  { render :xml => @batch, :status => :created }
    #   else
    #     format.html { render :action => "new" }
    #     format.xml  { render :xml => @batch.errors, :status => :unprocessable_entity }
    #   end
    # end
  end

end
