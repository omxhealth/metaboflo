class SampleManifiestsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :authenticate_client!

  def index
    respond_with Entry.all
  end
  
  def show
    respond_with Entry.find(params[:id])
  end
  
  def create
    respond_with Entry.create(params[:sample_manifest])
  end
  
  def update
    respond_with Entry.update(params[:id],params[:sample_manifest])
  end
  
  def destroy
    respond_with Entry.destroy(params[:sample_manifest])
  end
  
end