class UsersController < ApplicationController
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def index
    if params[:site_id]
      @site = Site.find(params[:site_id])
      @users = @site.users
    else
      @users = User.find(:all)
    end
  end
  
  protected
    def authorized?
      super && (current_user.rank == 'Superuser' || current_user.rank == 'Administrator')
    end
end
