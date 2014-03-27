class SubjectsController < ApplicationController
  
  #layout false 
  layout "admin"

  before_action :confirm_logged_in #every action in here is going to confirm you are logged in

  def index
    #assemlbe a list of all the subjects
    # @subjects = Subject.all or
    @subjects = Subject.sorted #defined in lambda
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => "default"})
    #@subject = Subject.new ^ will display 'defualt in the field'
    @subject_count = Subject.count + 1
    # +1,  we need do this for example subject 11 at postion 11, this could be the 4th one, when there are 3, why we plus 1
    # when we edit there are only the exact amount, so we dont need the + 1 
  end

  def create
    #instantiate a new object using form paramters\
    @subject = Subject.new(subject_params)

    #save the object
    if @subject.save
    #if save succeeds, redirect to the index action
    flash[:notice] = "Subject created successfully."
    redirect_to(:action => 'index')
    else 
    #if save fails, redisplay the form so user can fix problems
    @subject_count = Subject.count + 1 #need to define this again because it will go back to the edit page with no instance of @whatever
      #there is a possibilty we could add another one to the subjects
      render('new') #go to the new page and make the form
    end
  end

 

  def edit
     @subject = Subject.find(params[:id])
     @subject_count = Subject.count # on the subject _form, this will count how many subjects we have 
  end

  def update
    # find an existing object using form paramters 
    @subject = Subject.find(params[:id])

    #update the object
    if @subject.update_attributes(subject_params)
  
    #if update succeeds, redirect to the show page
    flash[:notice] = "Subject Updated successfully."
    redirect_to(:action => 'show', :id => @subject.id)
    else 
    #if update fails, redisplay the form so user can fix problems
      @subject_count = Subject.count
      render('edit') #go to the new page and make the form
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id])
    # or
    # subject = Subject.find(params[:id]).destroy --> called daisy chaining
    subject.destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed."
    redirect_to(:action => 'index')

    #dont need to use @, we instaniated this object, and set it to the instance variable @subject, since the action will not display a template, we dont need to use a instance varible. Can just you a local variable 

  end 

  private #make it private so it cant be called as an action, instead it is just a method
    def subject_params
      #same as using "paramas[:subject]", except that it:
      #  - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned 
      params.require(:subject).permit(:name, :position, :visible, :created_at)
    end
end
