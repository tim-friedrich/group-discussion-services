class AddTypeToArguments < ActiveRecord::Migration
  def change
    add_column :arguments, :argument_type_id, :integer
  end
end
