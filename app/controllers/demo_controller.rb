class DemoController < ApplicationController
  
  
  layout 'application'

  def index
  	#render('demo/hello') # the name of the template is just hello
  						 #render is just rendering the template 
  end

  def hello 
  	#good pratice tom always have a action matching the template 
  	#array = just a reg var


  	@array = [1,2,3,4,5]

  	@id = params['id'] # these are both interchangeable can use : or not
  	@page = params[:page] #
  end 




  def other_hello
  	redirect_to(:controller => 'demo', :action => 'index') # stays on the demo controller, goes to index action
  end

  def lynda
  	redirect_to('http://google.com')
  end

  def text_helpers

  end

  def escape_output

  end
end


