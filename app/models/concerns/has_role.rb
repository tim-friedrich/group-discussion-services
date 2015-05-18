module HasRole
  def is_moderator?
    self.role == Role.moderator
  end

  def is_proband?
    self.role == Role.proband
  end

  def is_guest?
    self.role == nil
  end

  def is_admin?
    self.role == Role.admin
  end

  def is_staff?
    self.role == Role.moderator
  end

  def is_customer?
    self.role == Role.customer
  end

  def set_default_role
    self.role ||= Role.proband
  end
end