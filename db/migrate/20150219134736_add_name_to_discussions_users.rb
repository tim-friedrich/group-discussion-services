class AddNameToDiscussionsUsers < ActiveRecord::Migration
  def change
    add_column :discussions_users, :name, :string
  end
end
