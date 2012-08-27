class Api::SampleManifestsController < Api::BaseController
  skip_before_filter :authenticate_user!
  before_filter :authenticate_client!

  def index
    respond_with current_client.sample_manifests
  end
  
  def show
    respond_with SampleManifest.find(params[:id])
  end
  
  def create
    respond_with SampleManifest.create(params[:sample_manifest])
  end
  
  def update
    respond_with SampleManifest.update(params[:id],params[:sample_manifest])
  end
  
  def destroy
    respond_with SampleManifest.destroy(params[:sample_manifest])
  end
  
end