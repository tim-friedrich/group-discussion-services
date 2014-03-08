# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.delete_all
Role.create!(name: 'user', level: 1)
Role.create!(name: 'moderator', level: 2)
Role.create!(name: 'deputy', level: 3)
Role.create!(name: 'admin', level: 4)

ArgumentType.delete_all
ArgumentType.create!(name: 'proband')
ArgumentType.create!(name: 'moderator')
ArgumentType.create!(name: 'observer')


User.delete_all
User.create!([{
		firstname: "Tim",
		lastname: "Friedrich",
		email: "friedrich.tim@googlemail.com",
	   	role_id: Role.where(name: 'admin').first.id,
	   	password: "123456789",
	   	password_confirmation: "123456789"
	}])