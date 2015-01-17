class AddConfirmedToDiscussionsUser < ActiveRecord::Migration
  def change
    add_column :discussions_users, :confirmed, :boolean, default: false
  end
end
