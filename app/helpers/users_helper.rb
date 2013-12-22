module UsersHelper
	def is_staff?(user)
		user.role == Role.where(name: 'staff').first
	end

	def is_admin?(user)
		user.role == Role.where(name: 'admin').first
	end

	def is_user?(user)
		user.role == Role.where(name: 'user').first
	end
end
