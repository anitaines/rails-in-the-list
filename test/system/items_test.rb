require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  def setup
    @user = users(:one)
    login_as(@user, :scope => :user)
  end

  test "creating a new item from dashboard" do
    visit lists_url

    find(".list-card:first-of-type .btn[data-action='click->new-item-dashboard#displayForm']", text: "Add Item").click

    assert_selector ".simple_form.new-item p", text: lists(:one).name

    fill_in "item[amount]", with: "Jules Verne was a French author who pioneered the genre of science fiction in the late nineteenth and early twentieth century."
    fill_in "item[comment]", with: "Test comment"
    find(".simple_form.new-item .btn-confirm").click
    assert_text "Name can't be blank"

    click_on "Cancel"

    find(".list-card:first-of-type .btn[data-action='click->new-item-dashboard#displayForm']", text: "Add Item").click

    assert_no_text "Name can't be blank"
    assert_empty find_field("item[amount]").value
    assert_no_text "Amount is too long (maximum is 55 characters)"
    assert_empty find_field("item[comment]").value
    assert_none_of_selectors "is-valid"
    assert_none_of_selectors "is-invalid"

    fill_in "item[name]", with: "Test name"
    fill_in "item[comment]", with: "Test comment"
    find(".simple_form.new-item .btn-confirm").click

    assert_selector ".list-card:first-of-type .card-image .status p", text: "- 1/2 Done -"
  end

  test "creating a new item from list" do
    list = lists(:one)
    current_items_number = list.items.count

    visit list_url(list)

    find(".simple_form.new-item-form #item_amount").fill_in with: "1"
    find(".simple_form.new-item-form #item_comment").fill_in with: "Test comment"
    find(".simple_form.new-item-form .btn").click
    assert_text "- Error in name: can't be blank."

    find(".simple_form.new-item-form #item_name").fill_in with: "Test name"
    find(".simple_form.new-item-form .btn").click
    assert_no_text "- Error in name: can't be blank."

    assert_selector "li.item", count: current_items_number + 1
  end

  test "marking an item as done" do
    list = lists(:one)

    visit list_url(list)

    find("li.item:first-child .purchased .fa-circle-check").click
    assert_no_text "Done by"

    find("li.item:first-child .purchased .fa-circle").click
    assert_text "Done by"
  end

  test "deleting an item" do
    list = lists(:one)
    current_items_number = list.items.count

    visit list_url(list)

    find(".tab-usual-items").click

    find("li.item:first-child .fa-trash-can").click
    click_on "Yes"

    assert_selector "li.item", count: current_items_number - 1
    assert_text "List is empty"
  end
end
