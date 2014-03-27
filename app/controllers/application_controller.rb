class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private # not callable from people outside this class, user cant do it as an action 
  	def confirm_logged_in
  		#if session[:user_id].nil? this also worked (i like this better)

  		unless session[:user_id] #unless that user has that session id, given above, aka if they dont have it 
  			flash[:notice] = 'please log in'
  			redirect_to(:controller => 'access', :action => 'login') #1
  			return false #halts the before action. stops things here
  			# so, unless you have to session id, please log in and get it, if you do, it's true and proceed 
  		else
  			return true #don't need this per say
  		end 
  	end
end

#1 there is no action controller in login, it is located in access controller, so we need to change it. Will redirect_to access login 