# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.delete_all
Role.create!(name: 'user', level: 1)
Role.create!(name: 'staff', level: 2)
Role.create!(name: 'deputy', level: 3)
Role.create!(name: 'admin', level: 4)


ArgumentType.delete_all
ArgumentType.create!(name: 'proband')
ArgumentType.create!(name: 'moderator')
ArgumentType.create!(name: 'observer')


ResearchInstitute.delete_all
ResearchInstitute.create!(
	[
		{
			id: 1,
			name: "Buchstabensuppe",
			contact_id: 2,
			#created_at: datetime,
			#updated_at: datetime,
			deputy_id: 2
		}
	])


User.delete_all
User.create!(
	[
		{
			firstname: "Tim",
			lastname: "Friedrich",
			email: "friedrich.tim@googlemail.com",
		   	role_id: Role.where(name: 'admin').first.id,
		   	password: "123456",
		   	password_confirmation: "123456",
		   	research_institutes: [ResearchInstitute.take]
		},

		{
			firstname: "Falco",
			lastname: "D.",
			email: "falco@example.org",
			role_id: Role.where(name: 'admin').first.id,
			password: 'test42',
			password_confirmation: 'test42',
			research_institutes: [ResearchInstitute.take]
		}
	])


Contact.delete_all
Contact.create!(
	[
		{
			research_institutes: [ResearchInstitute.take],
		}
	])


Company.delete_all
Company.create!(
	[
		{
			contact: Contact.take,
			research_institute: ResearchInstitute.take
		}
	])
