class UserPicturesController < ApplicationController
  # # GET /user_pictures
  # # GET /user_pictures.xml
  # def index
  #   @user_pictures = UserPicture.find(:all)
  # 
  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.xml  { render :xml => @user_pictures }
  #   end
  # end

  # # GET /user_pictures/1
  # # GET /user_pictures/1.xml
  # def show
  #   @user_picture = UserPicture.find(params[:id])
  # 
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.xml  { render :xml => @user_picture }
  #   end
  # end

  # GET /user_pictures/new
  # GET /user_pictures/new.xml
  def new
    @user = User.find(params[:user_id])
    @user_picture = UserPicture.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_picture }
    end
  end

  # GET /user_pictures/1/edit
  def edit
    @user = User.find(params[:user_id])
    @user_picture = UserPicture.find(params[:id])
  end

  # POST /user_pictures
  # POST /user_pictures.xml
  def create
    @user = User.find(params[:user_id])
    @user_picture = UserPicture.new(params[:user_picture])
    @user_picture.user = @user

    respond_to do |format|
      if @user_picture.save
        flash[:notice] = 'User Picture was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user_picture, :status => :created, :location => @user_picture }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_pictures/1
  # PUT /user_pictures/1.xml
  def update
    @user = User.find(params[:user_id])
    @user_picture = UserPicture.find(params[:id])

    respond_to do |format|
      if @user_picture.update_attributes(params[:user_picture])
        flash[:notice] = 'User picture was successfully changed.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_pictures/1
  # DELETE /user_pictures/1.xml
  def destroy
    @user = User.find(params[:user_id])
    @user_picture = UserPicture.find(params[:id])
    @user_picture.destroy

    respond_to do |format|
      format.html { redirect_to(user_user_pictures_url(@user)) }
      format.xml  { head :ok }
    end
  end
end
