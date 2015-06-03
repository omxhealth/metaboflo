# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery
  
  helper :all # include all helpers, all the time
  
  before_filter :authenticate_user!
  
  def after_sign_in_path_for(resource)
    if current_user.admin?
      redirect_to 'users#index'
    else
      redirect_to 'clients#index'
    end
  end
  
  
  def layout_by_resource
    if devise_controller? && resource_name == :client
      'public'
    else
      'lims'
    end
  end

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
    @test_subject = current_user.rank == 'Superuser' || current_user.rank == 'Administrator' ?
                TestSubject.find(params[param_name]) :
                TestSubject.find(params[param_name], :conditions => [ 'site_id=?', current_user.site ])
  end
end
