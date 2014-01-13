class DropDiscussionsUsers < ActiveRecord::Migration
  def up
    drop_table :discussions_users
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
