# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "********Seeding Data Start************"


AdminUser.create(:first_name => "Kyle", :last_name => "Anderson", :email => "msuande1396@yahoo.com", :username => "ande1396", :password => "testpassword", :password_confirmation => "testpassword")


puts "********Seeding Data End************"