class AddMoreFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :phone, :string
    add_column :users, :industry, :string
    add_column :users, :pseudonym_policy, :boolean
    add_column :users, :can_be_called, :boolean
  end
end
