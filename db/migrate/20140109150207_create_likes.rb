class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :argument
      t.integer :user

      t.timestamps
    end
  end
end
