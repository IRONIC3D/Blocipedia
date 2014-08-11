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

  def edit?
    user.present? && (record.original_user == user || user.role?(:admin) || record.collaborators.where(user_id: user.id).length > 0)
  end

end