class RenameKontaktIdFromResearchInstituteToContactId < ActiveRecord::Migration
  def change
    rename_column :research_institutes, :kontakt_id, :contact_id
  end
end
