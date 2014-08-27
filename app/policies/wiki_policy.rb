class WikiPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    record.original_user == user || user.role?(:admin) || record.collaborators.where(user_id: user.id).length > 0 || user.present?
  end

  def create?
    user.present?
  end

  def edit?
    user.present? && (record.original_user == user || user.role?(:admin) || record.collaborators.where(user_id: user.id).length > 0)
  end

  def update?
    edit?
  end

  def collaborate?
    user.status?(:subscribed)
  end

  def private?
    if !(record.private?)
      user.present?
    else
      record.original_user == user || user.role?(:admin) || record.collaborators.where(user_id: user.id).length > 0
    end
  end

end