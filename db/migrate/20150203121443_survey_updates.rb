class SurveyUpdates < ActiveRecord::Migration
  def change
    rename_column :surveys, :x, :h
    add_column :surveys, :user_id, :integer
  end
end
