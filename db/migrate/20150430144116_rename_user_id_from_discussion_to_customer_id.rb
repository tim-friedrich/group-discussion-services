class RenameUserIdFromDiscussionToCustomerId < ActiveRecord::Migration
  def change
  	rename_column :discussions, :user_id, :customer_id
  end
end
