# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery

  before_action :authenticate_user!

  def layout_by_resource
    if user_signed_in?
      'lims'
    elsif client_signed_in?
      'client'
    else
      'public'
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
    current_user.superuser? || current_user.administrator?
  end

  protected

  def only_user?(redirect_path = root_path)
    redirect_to redirect_path unless current_user.superuser? || current_user.administrator?
  end

  def administrator?(redirect_path = root_path)
    redirect_to redirect_path unless current_user.administrator?
  end

  def find_test_subject(id_param = :test_subject_id)
    @test_subject =
      if current_user.superuser? || current_user.administrator?
        TestSubject.find(params[id_param])
      else
        current_user.site.test_subjects.find(params[id_param])
      end
  end
end
