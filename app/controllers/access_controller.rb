class AccessController < ApplicationController
  
	layout 'admin' #this made the css appear

	before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout ] #anthing in here except for those 3

  def index
  	#display text and links 
  end

  def login
  	#display login form
  end

  def attempt_login
  	if params[:username].present? && params[:password].present? #1
  		found_user = AdminUser.where(:username => params[:username]).first #2

  		if found_user
  			authorized_user = found_user.authenticate(params[:password]) #just like we did on the command line #3
  		end
  	end
  	if authorized_user
  		#TODO: mark user as logged in # DONE (bleow)
  		session[:user_id] = authorized_user.id
  		session[:username] = authorized_user.username 
  		flash[:notice] = 'You are now logged in'
  		redirect_to(:action => 'index')
  	else
  		flash[:notice] = 'Invalid username/password'
  		redirect_to(:action => 'login')

  	end 
  	
  end

  def logout
  	# TODO: make user logged out ( DONe )
  	session[:user_id] = nil #marks the user as logged out 
    session[:user_id] = nil
  	flash[:notice] = "logged out"
  	redirect_to(:action => 'login')
  	
  end

 #since all of the code will is the confirm log in, we put it in application controller 

  #private ######## not callable from people outside this class, user cant do it as an action 
  	#def confirm_logged_in
  		#unless session[:user_id] #######unless that user has that session id, given above, aka if they dont have it 
  			#flash[:notice] = 'please log in'
  			#redirect_to(:action => 'login')
  			#return false ###########halts the before action. stops things here
  			######################## so, unless you have to session id, please log in and get it, if you do, it's true and proceed 
  		#else
  			#return true ############don't need this per say
  		#end 
  	#end
end


#1 making sure we have values for both aka they are not empty, no point in going
## to the db if they are not there , present? -> check if it's not blank


#2 then we will go to AdminUser and find the username is == to the first one, if we dont
## find one we will get back nill 

#3 checking to see if the password match in the db.
# if it does, it will return the found user to us again 
## it's either going to be an object or false 


## I am going to confirm they are logged in, except for 3 different actions 
# they dont need to have this run if they are looking at the log in page or
# are attempting to log in