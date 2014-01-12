class RenameUserFromLikesToUserId < ActiveRecord::Migration
  def change
  	rename_column :likes, :user, :user_id
  end
end
