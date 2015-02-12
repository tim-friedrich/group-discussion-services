class AddQuestionId < ActiveRecord::Migration
  def change
    add_column :arguments, :question_id, :integer
  end
end
#