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
puts 'user: ' << user.name
user.add_role :admin

Entry.create(stick_week:1, plant_id:1, location_id:1, pots:896)
Entry.create(stick_week:12, plant_id:1, location_id:1, pots:3000)
Entry.create(stick_week:10, plant_id:1, location_id:1, pots:0)
Entry.create(stick_week:11, plant_id:1, location_id:1, pots:9706)
Entry.create(stick_week:1, plant_id:1, location_id:1, pots:896)
Entry.create(stick_week:3, plant_id:1, location_id:1, pots:3304)
Entry.create(stick_week:5, plant_id:1, location_id:1, pots:23517)
Entry.create(stick_week:4, plant_id:1, location_id:1, pots:3304)
Entry.create(stick_week:6, plant_id:1, location_id:1, pots:5890)
Entry.create(stick_week:7, plant_id:1, location_id:1, pots:0)
Entry.create(stick_week:8, plant_id:1, location_id:1, pots:3836)
Entry.create(stick_week:9, plant_id:1, location_id:1, pots:3243)
Entry.create(stick_week:2, plant_id:1, location_id:1, pots:3220)
