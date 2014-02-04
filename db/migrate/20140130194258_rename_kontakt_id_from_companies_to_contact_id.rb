class RenameKontaktIdFromCompaniesToContactId < ActiveRecord::Migration
  def change
  	rename_column :companies, :kontakt_id, :contact_id
  end
end
