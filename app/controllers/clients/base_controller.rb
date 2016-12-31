class Clients::BaseController < ApplicationController
  layout 'client'
  skip_before_action :authenticate_user!
  before_action :authenticate_client!
end
