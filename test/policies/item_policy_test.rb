require 'test_helper'

class ItemPolicyTest < ActiveSupport::TestCase
  def setup
    @user = users(:three)
    @list = lists(:one)
  end

  # def test_scope
  #   # This test should ensure that the policy scope returns only items that the user has access to
  #   skip "Implement the test_scope test"
  # end

  def test_create
    item = Item.new
    item.list = @list

    assert_not ItemPolicy.new(@user, item).create?, "user should NOT be authorized to create an item"

    UserList.create(user: @user, list: @list, admin: false)

    assert ItemPolicy.new(@user, item).create?, "user should be authorized to create an item"
  end

  def test_update
    item = Item.new
    item.list = @list

    assert_not ItemPolicy.new(@user, item).update?, "user should NOT be authorized to update an item"

    UserList.create(user: @user, list: @list, admin: false)

    assert ItemPolicy.new(@user, item).update?, "user should be authorized to update an item"
  end

  def test_destroy
    item = Item.new
    item.list = @list

    assert_not ItemPolicy.new(@user, item).destroy?, "user should NOT be authorized to destroy an item"

    UserList.create(user: @user, list: @list, admin: false)

    assert ItemPolicy.new(@user, item).destroy?, "user should be authorized to destroy an item"
  end
end
