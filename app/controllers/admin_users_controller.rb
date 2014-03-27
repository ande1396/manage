class AdminUsersController < ApplicationController
  layout 'admin'

  #restrict access to all actions to logged in users 
  before_action :confirm_logged_in 

  def index
    #adminusers sorted by_last_name, then first _name 
    @admin_users = AdminUser.sorted
  end

  def new
    #make a new admin user, diplsy the form 
    @admin_user = AdminUser.new #just here to have a new object on the page 
  end

  def create
    #create a new adminuser
   

    @admin_user = AdminUser.new(admin_user_params)
    #if it saves, 
    if @admin_user.save
      # success
      flash[:notice] = 'Admin user created.'
      redirect_to(:action => 'index') 

      #go to index page i think

    else
      # display errors
      #flash[:notice] = 'Could not register Admin User'
      render("new")
    end 

  end

  def edit
    #edit the adminuser, use the id 
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    #update the adminuser, use the id
    @admin_user = AdminUser.find(params[:id])
    if @admin_user.update_attributes(admin_user_params)
      flash[:notice] = 'Admin user updated.'
      redirect_to(:action => 'index')
    else
      render("edit")
    end 
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    #destroy the admin user, with id, send back to index
    AdminUser.find(params[:id]).destroy
    flash[:notice] = "Admin user destroyed."
    redirect_to(:action => 'index')
  end

  private #strong parameters 
    def admin_user_params
    params.require(:admin_user).permit(:first_name, :last_name,
      :email, :username, :password, :password_confirmation)
    end
end
