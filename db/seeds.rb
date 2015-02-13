
Role.create!(name: 'user', level: 1) unless Role.find_by_name('user')
Role.create!(name: 'proband', level: 1) unless Role.find_by_name('proband')
Role.create!(name: 'observer', level: 2) unless Role.find_by_name('observer')
Role.create!(name: 'moderator', level: 2) unless Role.find_by_name('moderator')
Role.create!(name: 'deputy', level: 3) unless Role.find_by_name('deputy')
Role.create!(name: 'admin', level: 4) unless Role.find_by_name('admin')

ArgumentType.create!(name: 'proband') unless ArgumentType.find_by_name('proband')
ArgumentType.create!(name: 'moderator') unless ArgumentType.find_by_name('moderator')
ArgumentType.create!(name: 'observer') unless ArgumentType.find_by_name('observer')