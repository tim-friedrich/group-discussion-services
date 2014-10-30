class AddRoleToDiscussionsUsers < ActiveRecord::Migration
  def change
    add_column :discussions_users, :role_id, :integer
  end
end
