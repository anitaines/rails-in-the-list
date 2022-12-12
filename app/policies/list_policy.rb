class ListPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
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
    # UserList.where(user: user, list: record).first.admin # returns TRUE or FALSE

    # other way:
    admin = UserList.where(list: record, admin: true).first.user
    admin == user
  end
end
