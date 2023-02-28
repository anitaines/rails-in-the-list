require "test_helper"

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @list = lists(:one)
    sign_in users(:one)
  end

  test "should create invitation" do
    assert_difference('Invitation.count') do
      post list_invitations_url(@list), params: { invitation: { invitation_to_id: "four@mail.com", message: "New Invitation from Dashboard" }, origin: "dashboard" }
    end
    assert_redirected_to lists_url

    assert_difference('Invitation.count') do
      post list_invitations_url(@list), params: { invitation: { invitation_to_id: "five@mail.com", message: "" }, origin: "list" }
    end
    assert_redirected_to list_url(@list)
  end

  test "accept invitation should create UserList" do
    invitation = invitations(:one)

    assert_difference('UserList.count') do
      post accept_invitation_url(invitation)
    end

    assert_equal( invitation.invitation_to, UserList.last.user, "UserList created for the wrong user")

    assert_redirected_to list_url(UserList.last.list)
  end

  test "accept invitation should delete invitation" do
    invitation = invitations(:one)

    assert_difference('Invitation.count', -1) do
      post accept_invitation_url(invitation)
    end
  end

  test "destroy should delete invitation and redirect to lists" do
    invitation = invitations(:one)

    assert_difference('Invitation.count', -1) do
      delete invitation_url(invitation), params: { origin: "dashboard" }
    end
    assert_redirected_to lists_url
  end

  test "destroy should delete invitation and redirect to list(id)" do
    invitation = invitations(:one)

    assert_difference('Invitation.count', -1) do
      delete invitation_url(invitation), params: { origin: "list" }
    end
    assert_redirected_to list_url(invitation.list)
  end

  test "destroy should not create UserList" do
    invitation = invitations(:one)

    assert_no_difference('UserList.count', 'An UserList should not be created (list origin)') do
      delete invitation_url(invitation), params: { origin: "list" }
    end

    invitation = invitations(:two)

    assert_no_difference('UserList.count', 'An UserList should not be created (dashboard origin)') do
      delete invitation_url(invitation), params: { origin: "dashboard" }
    end
  end
end
