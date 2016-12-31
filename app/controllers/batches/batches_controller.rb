class Batches::BatchesController < ApplicationController

  # GET /batches/batches/new
  # GET /batches/batches/new.xml
  def new
    @samples = Array.new
    @num = params[:num_samples]
    if @num.blank?
      @num = 2
    end
    @num = @num.to_i

    (1..@num).each do
      @samples << Sample.new
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @batch }
    end
  end

  # POST /batches/batches
  # POST /batches/batches.xml
  def create
    @samples = params[:samples].values.map { |sample| Sample.new(sample) }

    saved = true
    Sample.transaction do

      @samples.each do |sample|
        if !sample.save
          saved = false
        end
      end

      if !saved
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
