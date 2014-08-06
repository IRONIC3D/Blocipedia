class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !(record.private?) || user.present? 
  end

  def create?
    user.present?
  end
end