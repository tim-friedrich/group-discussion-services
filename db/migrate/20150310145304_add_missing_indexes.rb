class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :research_institutes_users, :research_institute_id
    add_index :research_institutes_users, :user_id
    add_index :users, :role_id
    add_index :votes, :argument_id
    add_index :votes, :user_id
    add_index :visual_aids_logs, :visual_aid_id
    add_index :visual_aids, :discussion_id
    add_index :surveys, :user_id
    add_index :research_institutes, :contact_id
    add_index :research_institutes, :deputy_id
    add_index :questions, :discussion_id
    add_index :discussions_users, :discussion_id
    add_index :discussions_users, :user_id
    add_index :discussions_users, :role_id
    add_index :discussion_presences, :discussions_user_id
    add_index :discussions, :company_id
    add_index :companies, :contact_id
    add_index :companies, :research_institute_id
    add_index :arguments, :question_id
    add_index :arguments, :user_id
    add_index :arguments, :argument_type_id
    add_index :arguments, :discussion_id
  end
end
