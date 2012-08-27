class Public::PagesController < ApplicationController
  layout 'public'

  skip_before_filter :authenticate_user!
  skip_before_filter :authenticate_client!

  def home
  end
      
  def about
  end
  
  def services
  end

  def contact
  end
end
