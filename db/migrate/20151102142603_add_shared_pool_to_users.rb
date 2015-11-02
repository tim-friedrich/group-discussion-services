class AddSharedPoolToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shared_pool, :boolean, default: true
  end
end
