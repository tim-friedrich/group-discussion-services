class AddCompanyIdToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :company_id, :integer
  end
end
