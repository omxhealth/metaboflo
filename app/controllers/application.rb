# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout 'main'

  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'a347d8932ace59d533b9767c870630f9'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  protected
    def find_patient
      if params[:patient_id]
        @patient = Patient.find(params[:patient_id])
      else
        flash[:notice] = "Patient must be specified."
        respond_to do |format|
          format.html { redirect_to patients_url }
          format.xml { redirect_to formatted_patients_url }
        end
      end
    end
end
