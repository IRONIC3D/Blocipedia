class WikiPolicy < ApplicationPolicy

  def index?
    # TODO: Go over pundit readme on github for scoping
    true
  end

  def show?
    # TODO: Make it so only the creator can see this wiki, or collaborators
    !(record.private?) || user.present? 
  end

  def create?
    # TODO: Create a policy for paid user
    user.present?
  end

  def edit?
    user.present? && (record.original_user == user || user.role?(:admin) || record.collaborators.where(user_id: user.id).length > 0)
  end

  def collaborate?
    user.status?(:subscribed)
  end

end