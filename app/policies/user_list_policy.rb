class UserListPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   # scope.all
    # end
  end

  def destroy?
    record.admin == false && UserList.where(user: user, list: record.list).first
  end
end
