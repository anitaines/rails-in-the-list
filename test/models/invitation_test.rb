require "test_helper"

class InvitationTest < ActiveSupport::TestCase
  test "invalid without reference to list" do
    invitation = Invitation.new
    invitation.invitation_from = users(:one)
    invitation.invitation_to = users(:three)

    assert_not invitation.valid?, "invitation is valid without reference to list"
    assert_equal( "must exist", invitation.errors[:list].first, "no error related to list reference")
  end

  test "invalid without reference to user (invitation_from)" do
    invitation = Invitation.new
    invitation.list = lists(:one)
    invitation.invitation_to = users(:three)

    assert_not invitation.valid?, "invitation is valid without invitation_from"
    assert_equal( "must exist", invitation.errors[:invitation_from].first, "no error related to user reference (invitation_from)")
  end

  test "invalid without reference to user (invitation_to)" do
    invitation = Invitation.new
    invitation.list = lists(:one)
    invitation.invitation_from = users(:one)

    assert_not invitation.valid?, "invitation is valid without invitation_to"
    assert_equal( "must exist", invitation.errors[:invitation_to].first, "no error related to user reference (invitation_to)")
  end

  test "invitation cannot be send to a user that altready has an invitation to the same list" do
    invitation = Invitation.new
    invitation.list = lists(:one)
    invitation.invitation_from = users(:one)
    invitation.invitation_to = users(:three)

    assert_not invitation.valid?, "invitation is valid although user has already been invited"
    assert_equal( "- User has a pending invitation already", invitation.errors[:invitation_to_id].first, "no error related to user already being invited")
  end

  test "invitation cannot be send to a user that is altready on list" do
    invitation = Invitation.new
    invitation.list = lists(:one)
    invitation.invitation_from = users(:one)
    invitation.invitation_to = users(:two)

    assert_not invitation.valid?, "invitation is valid although user is already on the list"
    assert_equal( "- User is already part of the list", invitation.errors[:invitation_to_id].first, "no error related to user already being in the list")
  end
end
