class AddAdditionalUserFieldIdToFieldOptions < ActiveRecord::Migration
  def change
    add_column :user_field_options, :additional_user_field_id, :integer
  end
end
