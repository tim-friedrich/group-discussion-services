class CreateDiscussionPresences < ActiveRecord::Migration
  def change
    create_table :discussion_presences do |t|
      t.integer :discussion_user_id
      t.boolean :present

      t.timestamps
    end
  end
end
