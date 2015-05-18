class RemoveCustomerFromDiscussion < ActiveRecord::Migration
  def change
  	remove_column :discussions, :customer_id, :integer
  end
end
