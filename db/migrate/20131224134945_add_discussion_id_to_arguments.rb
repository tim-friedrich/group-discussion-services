class AddDiscussionIdToArguments < ActiveRecord::Migration
  def change
    add_column :arguments, :discussion_id, :integer
  end
end
