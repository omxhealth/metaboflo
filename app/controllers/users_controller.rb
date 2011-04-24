class UsersController < ApplicationController
  before_filter :find_site
  before_filter :find_user, :only => [ :show, :edit, :update, :destroy ]
  before_filter :authorize
  
  # GET /users
  # GET /users.xml
  def index
    if !@site.blank?
      @users = @site.users
    elsif current_user.rank == 'Administrator' || current_user.rank == 'Superuser'
      @users = User.find(:all)
    else
      @users = current_user.site.users
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
  end
  
  # POST /users
  # POST /users.xml
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

  # PUT /users/1
  # PUT /users/1.xml
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  def find_site
    @site = Site.find(params[:site_id]) unless params[:site_id].blank?
  end

  def find_user
    @user = @site.blank? ? User.find(params[:id]) : @site.users.find(params[:id])
  end

  def authorize
    case self.action_name
      when 'new', 'create'
        if !(current_user.rank == 'Superuser' || current_user.rank == 'Administrator')
          flash[:notice] = 'You are not authorized to create users.'
          redirect_to root_path
        end
      when 'edit', 'update'
        if !(current_user.rank == 'Superuser' || current_user.rank == 'Administrator' || current_user.id == params[:id].to_i)
          flash[:notice] = 'You are not authorized to edit the user.'
          redirect_to root_path
        end
      when 'destroy'
        if current_user.id == params[:id].to_i
          flash[:notice] = 'You cannot delete yourself.'
          redirect_to root_path
        elsif current_user.rank != 'Administrator'
          flash[:notice] = 'You are not authorized to delete users.'
          redirect_to root_path
        end
    end
  end
end
