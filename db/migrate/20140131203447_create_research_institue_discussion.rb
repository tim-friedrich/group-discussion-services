class CreateResearchInstitueDiscussion < ActiveRecord::Migration
  def change
    create_table :research_institue_discussions do |t|
      t.integer :research_institue_id 
      t.integer :discussion_id
      t.timestamp
    end
  end
end
