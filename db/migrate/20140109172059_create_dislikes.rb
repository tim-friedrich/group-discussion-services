class CreateDislikes < ActiveRecord::Migration
  def change
    create_table :dislikes do |t|
      t.integer :argument_id
      t.integer :user_id

      t.timestamps
    end
  end
end
