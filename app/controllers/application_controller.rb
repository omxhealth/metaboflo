# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout 'main'

  helper :all # include all helpers, all the time
  
  before_filter :authenticate_user!

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'a347d8932ace59d533b9767c870630f9'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  # remove objects where root test_subject is from another site
  def find_for_site(objects, site)
    #TODO *** IS THERE A BETTER WAY TO IMPLEMENT THIS??? ***

    site_objects = []
    objects.each do |o|
      site_objects << o if o.root.site == site
    end
    site_objects
  end
  
  def can_view_all(user)
    return (current_user.rank == 'Superuser' || current_user.rank == 'Administrator')
  end

  protected
    def only_user?(redirect_path = root_path)
      redirect_to redirect_path unless current_user.rank == 'Superuser' || current_user.rank == 'Administrator'
    end
  
    def administrator?(redirect_path = root_path)
      redirect_to redirect_path unless current_user.rank == 'Administrator'
    end
  
    def find_test_subject(param_name = :test_subject_id)
      @test_subject = (current_user.rank == 'Superuser' || current_user.rank == 'Administrator') ?
                  TestSubject.find(params[param_name]) :
                  TestSubject.find(params[param_name], :conditions => [ 'site_id=?', current_user.site ])

      #TODO: What if the test_subject isnt in this user's site? This currently throws an exception...
    end
end
