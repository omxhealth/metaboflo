class AdministratorsController < ApplicationController
  def index
  end

  def authorized?
    current_user.rank == 'Superuser' || current_user.rank == 'Administrator'
  end
end
