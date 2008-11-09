# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout 'main'

  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  
  before_filter :login_required

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'a347d8932ace59d533b9767c870630f9'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  protected
    def find_patient(param_name = :patient_id)
      @patient = current_user.rank == 'Superuser' || current_user.rank == 'Administrator' ?
                  Patient.find(params[param_name]) :
                  Patient.find(params[param_name], :conditions => [ 'site_id=?', current_user.site ])
    end
end
