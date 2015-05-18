class AddDescriptionToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :description, :string
  end
end
