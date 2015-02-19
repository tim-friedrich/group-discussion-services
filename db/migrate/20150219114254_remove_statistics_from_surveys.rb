

class RemoveStatisticsFromSurveys < ActiveRecord::Migration
  def up
    Survey.all.each{ |s|
      SurveyAnalyzer::STATISTICS.each{ |stat|
        s.public_send :"#{stat}=", s.statistics[stat.to_s]
      }
    }
    remove_column :surveys, :statistics
  end

  def down
    add_column :surveys, :statistics, :text
  end
end
