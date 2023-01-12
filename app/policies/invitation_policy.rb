class InvitationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    UserList.where(user: user, list: record.list).first
  end

  def destroy?
    Invitation.where(invitation_to: user, list: record.list).first || UserList.where(user: user, list: record.list).first
  end
end
