class DropDislikes < ActiveRecord::Migration
    def up
    drop_table :dislikes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
