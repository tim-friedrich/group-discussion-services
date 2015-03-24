class AddStateAndStateMessageToDiscussions < ActiveRecord::Migration
  def change
    add_column :discussions, :state, :string, default: 'closed'
    add_column :discussions, :state_message, :text, default: 'Die Diskussion ist geschlossen.'
  end
end
