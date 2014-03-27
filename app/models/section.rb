class Section < ActiveRecord::Base

	belongs_to :page
	has_many :section_edits
	has_many :editors, :through => :section_edits, :class_name => "AdminUser"

	acts_as_list :scope => :page

	after_save :touch_page #if you update the section, it will update the page  


	CONTENT_TYPES = ['text', 'HTML']
	# allowed to have text and html 

	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	validates_inclusion_of :content_type, :in => CONTENT_TYPES, :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
	# make sure the content types is in text or HTML
	validates_presence_of :content



  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
   scope :sorted, lambda { order("sections.position ASC") }
  scope :newest_first, lambda { order("sections.created_at DESC")}

  private
    	def touch_page
 
  		page.touch 
  		end
  


end
