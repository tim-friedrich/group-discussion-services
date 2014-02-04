class CreateContact < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :street
      t.string :postalcode
      t.string :town
      t.string :email
      t.string :telephone

      t.timestamps
    end
  end
end
