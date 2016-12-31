class AdministratorsController < ApplicationController
  before_action :authorize

  def index
  end

  def authorize
    if current_user.blank? || (current_user.rank != 'Superuser' && current_user.rank != 'Administrator')
      redirect_to root_path
    end
  end
end
