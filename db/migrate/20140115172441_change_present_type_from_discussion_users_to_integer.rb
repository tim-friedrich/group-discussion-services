class ChangePresentTypeFromDiscussionUsersToInteger < ActiveRecord::Migration
  def change
    remove_column :discussion_users, :present, :boolean, default:false
    add_column :discussion_users, :present, :integer
  end
end
