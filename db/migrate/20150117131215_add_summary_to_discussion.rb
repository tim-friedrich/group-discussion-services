class AddSummaryToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :summary, :text
  end
end
