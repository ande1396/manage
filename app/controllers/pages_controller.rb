class PagesController < ApplicationController
  
  #layout false
  layout "admin"

    before_action :confirm_logged_in #every action in here is going to confirm you are logged in 
    before_action :find_subject

  def index
    #@pages = Page.all #find all of the pages
    #@pages = Page.sorted #-> on page.rb
    @pages = Page.where(:subject_id => @subject.id).sorted #(better way below)
    #@pages = @subject.pages.sorted
    #ask for the pages where the subject id == subject id 
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:subject_id => @subject.id, :name => 'default'})
    @subjects = Subject.order('position ASC') #order in the position they are shown
    @page_count = Page.count + 1

  end

  def create
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts params
    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    @page = Page.new(page_params)

    #save the object
    if @page.save
    #if save succeeds, redirect to the index action
    flash[:notice] = "Page created successfully."
    redirect_to(:action => 'index', :subject_id => @subject.id)
    else 
    #if save fails, redisplay the form so user can fix problems
    @subjects = Subject.order('position ASC') 
    @page_count = Page.count + 1
      render('new') #go to the new page and make the form
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subjects = Subject.order('position ASC') #order in the position they are shown
    @page_count = Page.count 

  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated Successfully!"
      redirect_to(:action => 'show', :id => @page.id, :subject_id => @subject.id)
    else
      @subjects = Subject.order('position ASC') #order in the position they are shown
      @page_count = Page.count 
      render('index')
    end 
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    #page.destroy
    flash[:notice] = 'Page destroyed successfully'
    redirect_to(:action => 'index', :subject_id => @subject.id)
  end

  private 
    def page_params
      params.require(:page).permit(:subject_id, :name, :permalink, :position, :visible)
    end

    def find_subject
      if params[:subject_id]
        @subject = Subject.find(params[:subject_id])
      end
    end
    # everyone of these action in this controller is going to call the action--first thing, if it has subject_id sent, then it's going to find the subject_id in the db and set it to subject
end
