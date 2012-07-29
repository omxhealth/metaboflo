class Clients::SamplesController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :authenticate_client!
  
  def index
    @samples = current_client.samples
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @samples }
    end
  end
    
  def show
  end

end
