class RenameCompanyIdToUserId < ActiveRecord::Migration
  def change
  	rename_column :discussions, :company_id, :user_id
  end
end
