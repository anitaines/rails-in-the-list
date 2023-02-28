require 'test_helper'

class InvitationPolicyTest < ActiveSupport::TestCase
  def test_create
    user = users(:three)
    list = lists(:one)
    invitation = Invitation.new
    invitation.list = list

    assert_not InvitationPolicy.new(user, invitation).create?, "user should NOT be authorized to create an invitation"

    UserList.create(user: user, list: list, admin: false)

    assert InvitationPolicy.new(user, invitation).create?, "user should be authorized to create an invitation"
  end

  def test_destroy
    # user rejects invitation
    user_3 = users(:three)
    invitation_1 = invitations(:one)
    assert InvitationPolicy.new(user_3, invitation_1).destroy?, "user should be authorized to destroy an invitation (reject)"

    # user cancels invitation
    user_1 = users(:one)
    invitation_2 = invitations(:two)
    assert InvitationPolicy.new(user_1, invitation_2).destroy?, "user should be authorized to destroy an invitation (cancel)"
  end
end
