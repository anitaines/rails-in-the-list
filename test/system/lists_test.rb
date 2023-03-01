require "application_system_test_case"

class ListsTest < ApplicationSystemTestCase
  def setup
    @user = users(:one)
    login_as(@user, :scope => :user)
  end

  test "visiting the index" do
    visit lists_url
    assert_selector ".list-card", count: List.joins(:user_lists).where(user_lists: { user: @user }).count
  end

  test "creating a new list" do
    visit lists_url
    click_link "Create New List"
    # click_link href: new_list_path
    assert_current_path new_list_url

    fill_in "list[name]", with: "Test list name"
    click_on "Create List"
    assert_selector ".name", text: "Test list name"
  end

  test "updating list" do
    list = lists(:one)

    visit list_url(list)
    find(".fa-pen").click
    assert_current_path edit_list_path(list)

    fill_in "list[name]", with: "Updated list name"
    click_on "Update List"
    assert_selector ".name", text: "Updated list name"
  end

  test "deleting list" do
    list_cant_be_deleted = lists(:one)

    visit list_url(list_cant_be_deleted)
    find("a span .fa-trash-can").click
    assert_current_path edit_list_path(list_cant_be_deleted)

    assert_selector "button[disabled]" do
      assert_text "Delete List"
    end

    list_to_delete = lists(:two)

    visit list_url(list_to_delete)
    find("a span .fa-trash-can").click
    assert_current_path edit_list_path(list_to_delete)

    click_on "Delete List"
    click_on "Yes"
    assert_current_path lists_url

    assert_no_text list_to_delete.name
  end
end
