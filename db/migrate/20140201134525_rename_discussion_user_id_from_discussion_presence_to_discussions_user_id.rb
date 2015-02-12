class RenameDiscussionUserIdFromDiscussionPresenceToDiscussionsUserId < ActiveRecord::Migration
  def change
    rename_column :discussion_presences, :discussion_user_id, :discussions_user_id
  end
end
