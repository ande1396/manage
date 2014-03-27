class AddPasswordDigestToAdminUsers < ActiveRecord::Migration
  def up
  	remove_column "admin_users", "hashed_password"
  	#remove colummn from admin_users, name of column is hashed password 

  	add_column "admin_users", "password_digest", :string 
  	# "admin_users" is the table, name of column is password_digest
  end

  def down 
  	add_column "admin_users", "hashed_password", :string, :limit => 40 
  	remove_column "admin_users", "password_digest" 
  end 
end
