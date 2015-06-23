class CreateUsersAdditionalUserFields < ActiveRecord::Migration
  def change
    create_table :users_additional_user_fields do |t|
      t.integer :user_id
      t.integer :additional_user_field_id

      t.timestamps null: false
    end
  end
end
