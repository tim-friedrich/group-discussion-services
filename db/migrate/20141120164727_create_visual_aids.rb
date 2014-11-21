class CreateVisualAids < ActiveRecord::Migration
  def change
    create_table :visual_aids do |t|
      t.integer :discussion_id
      t.string :url

      t.timestamps
    end
  end
end
