class RenameFirstNameFromUsersTofirstname < ActiveRecord::Migration
  def change
    rename_column :users, :firstName, :firstname
  end
end
