class RemoveDislikesFromArguments < ActiveRecord::Migration
  def change
  	  remove_column :arguments, :dislikes, :integer
  end
end
