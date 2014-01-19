class Discussion < ActiveRecord::Base
	belongs_to :moderator, :class_name => "User", :foreign_key => "moderator_id"
	belongs_to :current_question, :class_name => "Question", :foreign_key => "current_question_id"
	has_many :questions
	has_many :arguments
	has_many :discussion_users
	has_many :users, through: :discussion_users

	accepts_nested_attributes_for :discussion_users,
           :reject_if => :all_blank,
           :allow_destroy => true
  	accepts_nested_attributes_for :users


end
