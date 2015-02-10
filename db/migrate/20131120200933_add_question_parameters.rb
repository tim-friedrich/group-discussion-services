class AddQuestionParameters < ActiveRecord::Migration
  def change
    add_column :questions, :topic, :string
    add_column :questions, :discription, :string
    add_column :questions, :group_discussion_id, :integer
  end
end
