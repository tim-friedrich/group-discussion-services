class DiscussionsUser < ActiveRecord::Base
	belongs_to :discussion
	belongs_to :user
	has_many :presences, :class_name => "DiscussionPresence"

	validates :user, uniqueness: { scope: :discussion }

	def enter_discussion
		DiscussionPresence.create(discussions_user_id: self.id, present: true)
	end

	def leave_discussion
		DiscussionPresence.create(discussions_user_id: self.id, present: false)
	end

	def is_present?
		if !self.presences.last.nil? && self.presences.last.present
			return self.presences.last.present == true
		else
			return false
		end
	end
end
