class AddColorToDiscussionsUsers < ActiveRecord::Migration
  def change
    add_column :discussions_users, :color, :string
  end
end
