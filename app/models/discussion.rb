class Discussion < ActiveRecord::Base
	belongs_to :moderator, :class_name => "User", :foreign_key => "moderator_id"
	has_many :questions
end
