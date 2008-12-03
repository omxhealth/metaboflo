class PasswordsController < ApplicationController

  def edit
    puts params[:password]
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      
      valid = true
      
      #Make sure old password is correct:
      if @user.crypted_password != @user.encrypt(params[:old_password])
        valid = false
        @user.errors.add :old_password, 'is incorrect'
      end
        
      if (valid and @user.update_attributes(params[:user]))
        flash[:notice] = 'Password was successfully updated.'
        format.html { redirect_to(user_url(@user)) }
        format.xml { head :ok }
      else
        valid = false
      end
        
      if not valid
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected

  def authorized?
    super && (current_user.rank == 'Superuser' || current_user.rank == 'Administrator')
  end

end
