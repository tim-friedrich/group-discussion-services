class RenameTypeOfAdditionalUserFieldsToFieldType < ActiveRecord::Migration
  def change
    rename_column :additional_user_fields, :type, :field_type
  end
end
