class RemovePresentFromDiscussionUsers < ActiveRecord::Migration
  def change
  	remove_column :discussion_users, :present, :integer
  end
end
