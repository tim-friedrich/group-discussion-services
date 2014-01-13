class DiscussionUser < ActiveRecord::Base
	belongs_to :discussion
	belongs_to :user
end
