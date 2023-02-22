require "test_helper"

class ItemTest < ActiveSupport::TestCase
  test "invalid without reference to list" do
    item = Item.new(name: "test item")

    assert_not item.valid?, "item is valid without reference to list"
    assert_not item.errors[:list].empty?, "no error related to list reference"
  end

  test "invalid without name" do
    item = Item.new
    item.list = lists(:one)

    assert_not item.valid?, "item is valid without a name"
    assert_not item.errors[:name].empty?, "no validation error for name present"
  end

  test "purchased date is humanized" do
    item = items(:one)

    assert_equal( "Monday, December 12 at 4:51PM", item.purchased_date_humanized, "purchased date is not humanized")
  end
end
