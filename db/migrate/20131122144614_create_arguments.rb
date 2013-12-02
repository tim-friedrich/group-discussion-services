class CreateArguments < ActiveRecord::Migration
  def change
    create_table :arguments do |t|
      t.string :content
      t.integer :user_id
      t.integer :likes
      t.integer :dislikes

      t.timestamps
    end
  end
end
