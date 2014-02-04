class CreateResearchInstituteUser < ActiveRecord::Migration
  def change
    create_table :research_institute_users do |t|
    	t.integer :research_institute_id
    	t.integer :user_id
    end
  end
end
