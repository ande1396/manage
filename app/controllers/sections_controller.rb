class SectionsController < ApplicationController

  #ayout false
  layout "admin"

    before_action :confirm_logged_in #every action in here is going to confirm you are logged in 
    before_action :find_page


  def index
    #@sections = Section.sorted
    #sections = Section.all
    #@sections = Section.where(:page_id => @page_id).sorted ## this didnt work!!!! ?
    @sections = @page.sections.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:page_id => @page.id, :name => "Default"})
    @pages = @page.subject.pages.sorted # dont want to select all of the pages, just the ones this section could reasonanly move to 
    # ^ this current page, as well as all of its siblings 
    @section_count = Section.count + 1
  end

  def create
    #instantiate a new object using form paramters\
    @section = Section.new(section_params)

    #save the object
    if @section.save
    #if save succeeds, redirect to the index action
    flash[:notice] = "Section created successfully."
    redirect_to(:action => 'index', :page_id => @page.id)
    else 
    #if save fails, redisplay the form so user can fix problems
      @pages = @page.subject.pages.sorted
      @section_count = Section.count + 1
      render('new') #go to the new page and make the form
    end
  end

  def edit
    @section = Section.find(params[:id])
    @pages = @page.subject.pages.sorted
    @section_count = Section.count
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully."
      redirect_to(:action => 'show', :id => @section.id, :page_id => @page.id)
    else
      @pages = @page.subject.pages.sorted
      @section_count = Section.count
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section destroyed successfully."
    redirect_to(:action => 'index', :page_id => @page.id)
  end

    private

    def section_params
      params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
    end

    def find_page
      if params[:page_id]
        @page = Page.find(params[:page_id])
      end
      
    end

end

#create update and destroy do not need templates in the views, so we don't do them on the comand line 
# only need methods for those 