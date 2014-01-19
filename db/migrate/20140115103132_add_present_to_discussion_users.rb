class AddPresentToDiscussionUsers < ActiveRecord::Migration
  def change
    add_column :discussion_users, :present, :boolean, default:false
  end
end
