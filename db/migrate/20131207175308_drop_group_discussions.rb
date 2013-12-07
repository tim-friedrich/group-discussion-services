
class DropGroupDiscussions < ActiveRecord::Migration
  def up
    drop_table :group_discussions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
