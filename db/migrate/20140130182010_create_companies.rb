class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :kontakt_id

      t.timestamps
    end
  end
end
