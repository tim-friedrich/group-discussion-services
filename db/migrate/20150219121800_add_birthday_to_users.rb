class AddBirthdayToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :birthyear
    add_column :users, :birthday, :date
  end
end
