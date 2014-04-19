# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'ROLES'
roles = ["admin"]
roles.each do |role|
  Role.find_or_create_by_name(role)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => "Alan Reichwein", :email => "Alan@whistlingpinesfoliage.com", :password => "changeme", :password_confirmation => "changeme"
user = User.find_or_create_by_email :name => "Doug Reichwein", :email => "Doug@whistlingpinesfoliage.com", :password => "changeme", :password_confirmation => "changeme"
puts 'user: ' << user.name
user.add_role :admin


