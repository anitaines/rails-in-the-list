class ListPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope.all
      scope.joins(:user_lists).where(user_lists: { user: user })
    end
  end

  def create?
    true
  end

  def show?
    UserList.where(user: user, list: record).first
  end

  def update?
    UserList.where(user: user, list: record).first
  end

  def destroy?
    user_list = UserList.where(user: user, list: record)

    unless user_list.empty?
      user_list.first.admin # returns TRUE or FALSE
    else
      false
    end
  end
end
