class RenameArgumentFromLikesToArgumentId < ActiveRecord::Migration
  def change
    rename_column :likes, :argument, :argument_id
  end
end
