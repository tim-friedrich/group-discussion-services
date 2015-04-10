class RefactorUsers < ActiveRecord::Migration
  def up
    create_table :user_relations do |t|
      t.user_id :user_id
      t.institute_id :integer
      t.institute_type :string
      t.role_id :integer
    end

    ResearchInstitute.all.each{ |ri|
      UserRelation.create!(
        user_id: ri.deputy_id,
        institute_id: ri.id,
        institute_type: "ResearchInstitute",
        role_id: Role.moderator,
      )

      ri.users.each{ |user|
        UserRelation.create!(
          user_id: user.id,
          institute_id: ri.id,
          institute_type: "ResearchInstitute",
          role_id: user.role_id,
        ) unless user.id == ri.deputy.id
      }
    }

    if deputy_role = Role.find_by_name('deputy')
      deputy_role.delete
    end

    remove_table :research_institutes_users
  end
end
