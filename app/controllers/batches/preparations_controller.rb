class Batches::PreparationsController < ApplicationController
  
  # GET /batches/preparations/new
  # GET /batches/preparations/new.xml
  def new
    @batch = Batch.new(:name => DateTime.now.strftime("%Y-%m-%d"))

    if (params[:samples])
      @samples = Sample.find(params[:samples])
    else
      flash[:notice] = 'You must select at least one sample to prep a batch'
      redirect_to(unprepped_batches_batches_path)
    end
  end

  # POST /batches/preparations
  # POST /batches/preparations.xml
  def create

    @samples = Array.new()

    saved = true
    Batch.transaction do 
      @batch = Batch.new(params[:batch])

      samples_hash = params[:samples]

      samples_hash.keys.each do |id|

        sample = Sample.find(id)

        @batch.samples << sample
        @samples << sample
        sample.preparing = true
        if not sample.update_attributes(samples_hash[id])
          saved = false
        end
      end

      if not @batch.save
        saved = false
      end

      if not saved
        raise ActiveRecord::Rollback, "Prepping failed!"
      end
    end

    if saved
      flash[:notice] = 'Batch was successfully created.'
      redirect_to(non_ph_batches_preparations_path)
    else
      render :action => "new"
    end

  end

  def non_ph
    #Shows all un-PH-ed batches along with their samples
    @batches = Batch.all


    #Customer.joins(:purchases).group("customer.id HAVING count(purchases.id) > 5")
  end

end
