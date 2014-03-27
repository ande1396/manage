class Page < ActiveRecord::Base

	belongs_to :subject
	has_many :sections
	# has_and_belongs_to_many :admin_users, below sounds better
	has_and_belongs_to_many :editors, :class_name => "AdminUser"



	acts_as_list :scope => :subject 

	before_validation :add_default_permalink
	# if the user doesnt provide a permalink, I am going to provide one for them 
	after_save :touch_subject #if you update the page, it will update the parent section

	after_destroy :delete_related_sections


	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	validates_presence_of :permalink
	validates_length_of :permalink, :within => 3..255
	#use presence_of with length_of to disallow spaces
	validates_uniqueness_of :permalink
	#  for unique values by subject use ":scope => :subject_id"

	scope :visible, lambda { where(:visible => true)}
	scope :invisible, lambda { where(:visible => false) }
	scope :sorted, lambda { order("pages.position ASC") }
  	scope :newest_first, lambda { order("pages.created_at DESC")}

  	private #only this class has access to it 

  	def add_default_permalink
  		if permalink.blank? # any time you are setting attributes in a model, it is importnat to use self
  		self.permalink =  "#{id}-#{name.parameterize}" # paramaetize- take this anme string and turn it into somthing that is sususitalbe for something in the url, get ride of any weird symbols, lowercase, etc
  		end 
  	end

  	#if it's balnk we are going to make sure it has this permalink 

  	def touch_subject
  		#touch is similar to:
  		# subject.update_attribute(:updated_at, Time.now)
  		subject.touch #update the timestamp for this subject. Anytime the page is update , lets mark the ubject as updated 
  		
  	end

  	def delete_related_sections
  		#self.sections do |section|
  			# also, can move them to another page, instead of destory
  			# section.destroy
  			### deleted a page, will delete the correspond sections 
  		
  	end

end
