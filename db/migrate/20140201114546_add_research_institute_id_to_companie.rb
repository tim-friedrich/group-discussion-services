class AddResearchInstituteIdToCompanie < ActiveRecord::Migration
  def change
  	add_column :companies, :research_institute_id, :integer 
  end
end
