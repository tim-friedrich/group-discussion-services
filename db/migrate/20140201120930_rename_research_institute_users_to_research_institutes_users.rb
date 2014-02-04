class RenameResearchInstituteUsersToResearchInstitutesUsers < ActiveRecord::Migration
  def self.up
    rename_table :research_institute_users, :research_institutes_users
  end

 def self.down
    rename_table :research_institutes_users, :research_institute_users
 end
end
