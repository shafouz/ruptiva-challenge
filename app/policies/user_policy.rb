class UserPolicy < ApplicationPolicy
  def index?
    user.role == "admin"
  end

  def admin_show?
    user.role == "admin"
  end
end
