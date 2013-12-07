class FixQuestionsDiscussionColumnname < ActiveRecord::Migration
  def self.up
    rename_column :questions, :group_discussion_id, :discussion_id
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
