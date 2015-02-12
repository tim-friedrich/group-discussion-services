class RenameCurrentQuestionFromDiscussionsToCurrentQuestionId < ActiveRecord::Migration
  def change
    rename_column :discussions, :current_question, :current_question_id
  end
end
