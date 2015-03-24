module UsersHelper
  def is_staff?(user)
    user.role == Role.find_by(name: 'staff')
  end

  def is_admin?(user)
    user.role == Role.find_by(name: 'admin')
  end

  def is_user?(user)
    user.role == Role.find_by(name: 'user')
  end
end
