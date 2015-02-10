class RemoveLikesFromArguments < ActiveRecord::Migration
  def change
    remove_column :arguments, :likes, :integer
  end
end
