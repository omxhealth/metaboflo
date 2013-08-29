class Public::PagesController < ApplicationController
  layout 'public'

  skip_before_filter :authenticate_user!
  skip_before_filter :authenticate_client!

  def home
    render :layout => false
  end
      
  def about
  end
  
  def services
  end

  def contact
  end
  
   def download_blank_manifest
    send_file 'spreadsheets/blank_manifest.xlsm', :type => 'application/vnd.ms-excel.sheet.macroEnabled.12'
  end
  
end
