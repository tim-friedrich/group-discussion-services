class DiscussionUser < ActiveRecord::Base
	belongs_to :discussion
	belongs_to :user
	belongs_to :present, :class_name => "DiscussionPresence", :foreign_key => "present"

	validates :user, uniqueness: { scope: :discussion }

end
