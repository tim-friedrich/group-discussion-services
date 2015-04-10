class CreateUserRelations < ActiveRecord::Migration
  def change
    create_table :user_relations do |t|
      t.integer :user_id
      t.integer :institute_id
      t.string :institute_type
      t.integer :role_id

      t.timestamps null: false
    end
  end
end
