class CreateUserFieldOptionsUsersAdditionalUserFields < ActiveRecord::Migration
  def change
    create_table :user_field_options_users_additional_user_fields do |t|
      t.integer :user_field_option_id
      t.integer :users_additional_user_field_id
    end
  end
end
