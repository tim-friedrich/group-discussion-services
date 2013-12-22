class RemoveDescriptionFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :discription, :string
  end
end
