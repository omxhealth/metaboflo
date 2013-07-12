class Clients::SampleManifestsController < Clients::BaseController  
  before_filter :unverified_manifest, :only => [:edit, :update, :confirm, :destroy]
  def index
    @sample_manifests = current_client.sample_manifests
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @sample_manifest = SampleManifest.new()
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @sample_manifest = SampleManifest.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def print
    @sample_manifest = SampleManifest.find(params[:id])
    respond_to do |format|
      format.html { render :print, :layout => false}
    end
  end
  
  def edit
  end
  
  def create
    @sample_manifest = SampleManifest.new(params[:sample_manifest])
    @sample_manifest.client = current_client
    respond_to do |format|
      if @sample_manifest.save
        format.html { redirect_to([:clients,@sample_manifest], :notice => 'Sample Manifest was successfully created.') }
      else
        format.html { render :action => "edit"}
      end
    end
  end
  
  def update
    respond_to do |format|
      if @sample_manifest.update_attributes(params[:sample_manifest])
          format.html { redirect_to([:clients,@sample_manifest], :notice => 'Sample manifest was successfully updated.') }
      else
          format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @sample_manifest.destroy
    respond_to do |format|
      format.html { redirect_to(clients_sample_manifests_url) }
    end
  end
  
  def confirm
  end
  
  def download_uploaded_manifest
     @sample_manifest = SampleManifest.find(params[:id])
     send_file "public/system/sample_manifests/sample_manifest_#{@sample_manifest.id}.xlsm", :type => 'application/vnd.ms-excel.sheet.macroEnabled.12'
  end
  
  def download_blank_manifest
    send_file 'spreadsheets/blank_manifest.xlsm', :type => 'application/vnd.ms-excel.sheet.macroEnabled.12'
  end
  
  def download_guideline
    send_file 'public/downloads/guidelines_for_all_samples_v1.pdf', :type => 'application/pdf'
  end
  
  private
  def unverified_manifest
   @sample_manifest = SampleManifest.find(params[:id])
   redirect_to([:clients,@sample_manifest], :notice => 'Already confirmed!') unless !@sample_manifest.verified?
  end
  
end
