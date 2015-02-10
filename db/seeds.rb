Role.delete_all
Role.create!(name: 'user', level: 1)
Role.create!(name: 'proband', level: 1)
Role.create!(name: 'observer', level: 2)
Role.create!(name: 'moderator', level: 2)
Role.create!(name: 'deputy', level: 3)
Role.create!(name: 'admin', level: 4)


ArgumentType.delete_all
ArgumentType.create!(name: 'proband')
ArgumentType.create!(name: 'moderator')
ArgumentType.create!(name: 'observer')

=begin example data
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
      username: "tim",
      firstname: "Tim",
      lastname: "Friedrich",
      email: "friedrich.tim@googlemail.com",
         role_id: Role.where(name: 'deputy').first.id,
         password: "123456789",
         password_confirmation: "123456789",
         research_institutes: [ResearchInstitute.take]
    },

    {
      username: "falco",
      firstname: "Falco",
      lastname: "D.",
      email: "falco@example.org",
      role_id: Role.where(name: 'deputy').first.id,
      password: 'test4321',
      password_confirmation: 'test4321',
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
=end