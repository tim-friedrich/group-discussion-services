class AddCurrentQuestionToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :current_question, :integer
  end
end
