class CreateVisualAidsLogs < ActiveRecord::Migration
  def change
    create_table :visual_aids_logs do |t|
      t.integer :visual_aid_id
      t.boolean :open

      t.timestamps
    end
  end
end
