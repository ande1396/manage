# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts "********Seeding Data Start************"


AdminUser.create(:first_name => "Kyle", :last_name => "Anderson", :email => "msuande1396@yahoo.com", :username => "ande1396", :password => "testpassword", :password_confirmation => "testpassword")


admin = AdminUser.create(:first_name => "Don", :last_name => "Anderson", :email => "ande1396@gmail.com", :username => "msuande1396", :password => "testpassword", :password_confirmation => "testpassword")

if admin.errors.blank?
    puts "***User #{admin.first_name} #{admin.last_name} created ***"
else
    puts "admin user failed to create due to below reasons:"
    admin.errors.each do |x, y|
       puts"#{x} #{y}" # x will be the field name and y will be the error on it
     end
end

puts "********Seeding Data End************"