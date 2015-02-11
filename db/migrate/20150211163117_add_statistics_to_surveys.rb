class AddStatisticsToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :statistics, :text
  end
end
