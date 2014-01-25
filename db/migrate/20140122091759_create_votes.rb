class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :argument_id
      t.integer :user_id
      t.boolean :is_like

      t.timestamps
    end
  end
end
