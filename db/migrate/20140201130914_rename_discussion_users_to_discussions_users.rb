class RenameDiscussionUsersToDiscussionsUsers < ActiveRecord::Migration
  def self.up
    rename_table :discussion_users, :discussions_users
  end

 def self.down
    rename_table :discussions_users, :discussion_users
 end
end
