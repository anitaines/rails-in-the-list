require "application_system_test_case"

class UserSharesListsTest < ApplicationSystemTestCase
  def setup
    @user = users(:one)
    login_as(@user, :scope => :user)
  end

  test "sharing list from dashboard" do
    visit lists_url

    find(".list-card:first-of-type .btn[data-action='click->new-invitation#displayForm']", text: "Share List").click

    assert_selector ".simple_form.new-invitation p", text: lists(:one).name

    fill_in "invitation[invitation_to_id]", with: "Non existent user"
    fill_in "invitation[message]", with: "Test message"
    click_on "Send invitation"
    assert_text "Invitation to - error: no user exists with this email"

    click_on "Cancel"

    find(".list-card:first-of-type .btn[data-action='click->new-invitation#displayForm']", text: "Share List").click

    assert_no_text "Invitation to - error: no user exists with this email"
    assert_empty find_field("invitation[invitation_to_id]").value
    assert_empty find_field("invitation[message]").value
    assert_none_of_selectors "is-valid"
    assert_none_of_selectors "is-invalid"

    fill_in "invitation[invitation_to_id]", with: users(:four).email
    fill_in "invitation[message]", with: "Test message"
    click_on "Send invitation"

    assert_selector ".list-card:first-of-type .no-avatar", count: 4
  end

  test "sharing list from list" do
    list = lists(:one)

    visit list_url(list)
    click_on "Share List"
    fill_in "invitation[invitation_to_id]", with: users(:four).email
    click_on "Send invitation"

    assert_selector ".user-card", count: 4
  end

  test "exiting list" do
    list = lists(:one)

    visit list_url(list)
    click_on "Exit List"
    click_on "Yes"

    assert_current_path lists_url
    assert_no_text list.name
  end

  test "admin user can't exit list" do
    list = lists(:two)

    visit list_url(list)

    assert_text "(Created by)"
  end

  test "removing user from list" do
    list = lists(:two)

    visit list_url(list)
    click_on "Remove"
    click_on "Yes"
    assert_selector ".user-card", count: 2
  end
  
  test "canceling user invitation" do
    list = lists(:two)

    visit list_url(list)
    click_on "Cancel invitation"
    click_on "Yes"
    assert_selector ".user-card", count: 2
  end

  test "accepting invitation" do
    logout
    user = users(:three)
    login_as(user, :scope => :user)

    visit lists_url

    find(".invitation:first-of-type .btn-confirm").click
    assert_current_path list_url(lists(:one))
  end

  test "rejecting invitation" do
    logout
    user = users(:three)
    login_as(user, :scope => :user)

    visit lists_url

    find(".invitation:first-of-type .btn-cancel").click
    click_on "Yes"
    assert_selector ".invitation", count: 1
  end
end
