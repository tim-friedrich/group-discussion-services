class AddGroupDiscussionParameters < ActiveRecord::Migration
  def change
    add_column :group_discussions, :name, :string
    add_column :group_discussions, :appointment, :date
    add_column :group_discussions, :description, :string 
  end
end
