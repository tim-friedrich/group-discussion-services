class CreateDiscussionUsers < ActiveRecord::Migration
  def change
    create_table :discussion_users do |t|
      t.integer :user_id
      t.integer :discussion_id

      t.timestamps
    end
  end
end
