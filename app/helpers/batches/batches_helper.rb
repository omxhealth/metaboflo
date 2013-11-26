module Batches::BatchesHelper

  # Prepares a new batch for creation (via form) by adding the required number of nested associations
  def setup_batch(batch)
    batch.tap do |e|
      e.samples.build until e.samples.size == 2
    end
  end
end
