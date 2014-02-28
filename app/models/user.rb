class User < ActiveRecord::Base

	has_many :arguments
	has_many :likes
	has_many :dislikes
	has_and_belongs_to_many :discussions
	has_and_belongs_to_many :research_institutes	

	has_one :research_institute
	
	belongs_to :role

	before_save { self.email = email.downcase }
	before_create :create_remember_token
	
	validates :firstname, presence: true, length: { maximum: 50 }
	validates :lastname, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	
	has_secure_password
	validates :password, length: { minimum: 6 }
	validates :password, presence:true
	
  	accepts_nested_attributes_for :discussions

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def full_name
		"#{firstname} #{lastname}"
	end

	def enter_discussion(discussion)
		DiscussionsUser.where(discussion_id: discussion.id, user_id: self.id).first.enter_discussion
	end

	def leave_discussion(discussion)
		DiscussionsUser.where(discussion_id: discussion.id, user_id: self.id).first.leave_discussion
	end

	def is_present_in(discussion)
		DiscussionsUser.where(discussion_id: discussion.id, user_id: self.id).first.is_present?
	end

	def is_part_of_discussion?(discussion)
		!discussion.users.find_by_id(self.id).nil?
	end

	def is_staff?()
		return (self.role == Role.where(name: 'moderator').first || self.role == Role.where(name: 'deputy').first)
	end

	private
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
