require "test_helper"

class ListTest < ActiveSupport::TestCase
  test "invalid without name" do
    list = List.new

    refute list.valid?, "list is valid without a name"
    assert_not list.errors[:name].empty?, "no validation error for name present"
  end
end
