class CreateResearchInstitutes < ActiveRecord::Migration
  def change
    create_table :research_institutes do |t|
      t.string :name
      t.integer :kontakt_id

      t.timestamps
    end
  end
end
