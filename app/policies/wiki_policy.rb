class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present? && user.role?(:admin)
  end
end