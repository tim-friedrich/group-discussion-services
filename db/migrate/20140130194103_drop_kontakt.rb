class DropKontakt < ActiveRecord::Migration
  def up
    drop_table :kontakts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
