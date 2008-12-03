class PasswordsController < ApplicationController
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if current_user.rank != 'Administrator' && current_user.rank != 'Superuser' && @user.crypted_password != @user.encrypt(params[:old_password])
      @old_password_message = 'Previous password is incorrect.'
    end
    
    respond_to do |format|
      if @old_password_message.blank? && @user.valid? && @user.update_attributes(params[:user])
        flash[:notice] = 'Password was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml { head :ok }
      else
        @user.errors.add_to_base(@old_password_message) unless @old_password_message.blank?
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected
    def authorized?(action = action_name, resource = nil)
      if super
        if current_user.rank == 'Superuser' || current_user.rank == 'Administrator' || current_user.id == params[:id].to_i
          return true
        else
          flash[:notice] = 'You are not authorized to update the user\'s password.'
          return false
        end
      else
        return false
      end
    end
end
