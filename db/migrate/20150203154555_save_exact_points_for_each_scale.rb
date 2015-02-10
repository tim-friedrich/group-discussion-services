class SaveExactPointsForEachScale < ActiveRecord::Migration
  def change
    %I[n e c a o lm mm sm h].each{ |column_name|
      change_column :surveys, column_name, :integer
      add_column :surveys, :"#{column_name}_points", :integer
    }
  end
end
