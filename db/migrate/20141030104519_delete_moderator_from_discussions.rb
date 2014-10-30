class DeleteModeratorFromDiscussions < ActiveRecord::Migration
  def change
    remove_column :discussions, :moderator_id, :integer
  end
end
