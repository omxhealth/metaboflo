class Clients::HomeController < Clients::BaseController
  def index
    respond_to do |format|
      format.html
    end
  end
end