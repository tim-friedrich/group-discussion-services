class RemoveResearchInstitutes < ActiveRecord::Migration
  def change
  	drop_table :research_institutes
  	drop_table :research_institutes_users
  end
end
