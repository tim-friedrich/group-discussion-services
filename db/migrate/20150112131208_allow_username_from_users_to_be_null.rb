class AllowUsernameFromUsersToBeNull < ActiveRecord::Migration
  def change
    change_column :users, :username, :string, :null => true
  end
end
