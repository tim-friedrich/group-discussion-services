class AddDeputyIdToResearchInstitute < ActiveRecord::Migration
  def change
    add_column :research_institutes, :deputy_id, :integer
  end
end
