class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :topic
      t.integer :moderator_id
      t.datetime :due_date

      t.timestamps
    end
  end
end
