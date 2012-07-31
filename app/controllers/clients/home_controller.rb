class Clients::HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :authenticate_client!
  
  def index
    respond_to do |format|
      format.html
    end
  end
end