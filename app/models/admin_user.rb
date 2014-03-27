class AdminUser < ActiveRecord::Base

  # To configure a different table name:
  # self.table_name = "admin_users"

 #ActiveRecord makes it so you don't have to do the attr_accessor for columns
 has_secure_password 


 has_and_belongs_to_many :pages 

 has_many :section_edits
 has_many :sections, :through => :section_edits

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  FORBIDDEN_USERNAMES = ['fu', 'money', 'killa']
  # ^^ this is the exact same thing validates exclusion_of does 

  # validates_presence_of :first_name
  # validates_length_of :first_name, :maximum => 25
  # validates_presence_of :last_name
  # validates_length_of :last_name, :maximum => 50
  # validates_presence_of :username
  # validates_length_of :username, :within => 8..25
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_length_of :email, :maximum => 100
  # validates_format_of :email, :with => EMAIL_REGEX
  #### ==          find out if this email is in the right format 
  # validates_confirmation_of :email
  #####  ==        hey re-enter this email address and check 


  # shortcut validations, aka "sexy validations"
  validates :first_name, :presence => true,
                         :length => { :maximum => 25 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 50 }
  validates :username, :length => { :within => 8..25 },
                       :uniqueness => true
  validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
                    :confirmation => true

  validate :username_allow 
  # singular 
  #validate :no_new_users_on_sunday, :on => :create


  def username_allow
    # add an error if the username is included
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username, 'has been restricted from use')
    end 
  end 

  def no_new_users_on_sunday
    if Time.now.wday == 7
      errors[:base] << "No new users on Sunday"
    end 

    # << push or appened it in 
  end 

  #assignment define a method #name whichc returns first_name and last_name with a space between 
  def name
     "#{first_name} #{last_name}" #called string interpilation
     ## could of done, first_name + ' ' + last_name
     ### or do an array: [first_name, last_name].join('')
  end
  #define a named scope called #sorted that orders by last_name, then first_name 
    scope :sorted, lambda { order("last_name ASC, first_name ASC") }
end
