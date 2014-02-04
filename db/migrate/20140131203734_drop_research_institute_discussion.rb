class DropResearchInstituteDiscussion < ActiveRecord::Migration
  def up
    drop_table :research_institue_discussions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
