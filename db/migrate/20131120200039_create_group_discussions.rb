class CreateGroupDiscussions < ActiveRecord::Migration
  def change
    create_table :group_discussions do |t|

      t.timestamps
    end
  end
end
