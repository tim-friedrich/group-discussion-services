module HasRole
  def is_moderator?
    self.role == Role.moderator
  end
  alias is_staff? is_moderator?

  def is_proband?
    self.role == Role.proband
  end

  # TODO needed?
  def is_guest?
    self.role == nil
  end

  def is_admin?
    self.role == Role.admin
  end

  def set_default_role
    self.role ||= Role.proband
  end
end