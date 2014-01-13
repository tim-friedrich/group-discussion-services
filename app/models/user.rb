class User < ActiveRecord::Base

	has_many :arguments
	has_many :likes
	has_many :dislikes
	has_many :discussion_users
	has_many :discussions, through: :discussion_users

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
	
	accepts_nested_attributes_for :discussion_users,
           :reject_if => :all_blank,
           :allow_destroy => true
  	accepts_nested_attributes_for :discussions

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end


	private
	
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
