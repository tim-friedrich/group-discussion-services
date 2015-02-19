class AddStatisticFieldsToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :school, :integer
    add_column :surveys, :degree, :integer
    add_column :surveys, :personal_status, :integer
    add_column :surveys, :income, :integer
  end
end
