class Batches::BatchesController < ApplicationController
  
  # GET /batches/batches/new
  # GET /batches/batches/new.xml
  def new
    #@batch = Batch.new(:name => DateTime.now.strftime("%Y-%m-%d"))

    @samples = Array.new

    @samples << Sample.new
    @samples << Sample.new    

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @batch }
    end
  end

  # POST /batches/batches
  # POST /batches/batches.xml
  def create

    @samples = params[:samples].values.collect { |sample| Sample.new(sample) }

    saved = true
    Sample.transaction do 

      @samples.each do |sample|
        puts sample
        if not sample.save
          saved = false
          puts "NOT SAVED"
        end
      end

      if not saved
        raise ActiveRecord::Rollback, "Creation failed!"
      end

    end

    if saved
      flash[:notice] = 'Samples were successfully created.'
      redirect_to(unprepped_batches_batches_path)
    else
      render :action => "new" 
    end

  end

  def unprepped
    #Shows all unprepped batches along with their samples
    @samples = Sample.all(:conditions => "dss_concentration is NULL")
  end

end
