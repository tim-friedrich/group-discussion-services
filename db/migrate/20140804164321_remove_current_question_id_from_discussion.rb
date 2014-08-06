class RemoveCurrentQuestionIdFromDiscussion < ActiveRecord::Migration
  def change
    remove_column :discussions, :current_question_id, :integer
  end
end
