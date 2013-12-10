# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.delete_all
Role.create(name: 'user', level: 1)
Role.create(name: 'staff', level: 2)
Role.create(name: 'admin', level: 3)

User.delete_all
User.create([{
		firstName: "Tim",
		surname: "Friedrich",
		email: "friedrich.tim@googlemail.com",
	   	role_id: Role.where(name: 'admin').first.id
	}])