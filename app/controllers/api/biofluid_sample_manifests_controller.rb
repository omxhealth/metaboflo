class BiofluidSampleManifestsController < Api::BaseController
  skip_before_filter :authenticate_user!
  before_filter :authenticate_client!

  def index
    respond_with BiofluidSampleManifest.all
  end
  
  def show
    respond_with BiofluidSampleManifest.find(params[:id])
  end
  
  def create
    respond_with BiofluidSampleManifest.create(params[:sample_manifest])
  end
  
  def update
    respond_with BiofluidSampleManifest.update(params[:id],params[:sample_manifest])
  end
  
  def destroy
    respond_with BiofluidSampleManifest.destroy(params[:sample_manifest])
  end
  
end