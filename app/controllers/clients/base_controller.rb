class Clients::BaseController < ApplicationController
  layout 'client'
  skip_before_filter :authenticate_user!
  before_filter :authenticate_client!
end