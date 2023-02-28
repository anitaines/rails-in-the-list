require 'test_helper'

class ListPolicyTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @list = lists(:three)
  end

  def test_scope
    list_1 = lists(:one)
    list_2 = lists(:two)
    list_3 = lists(:three)

    policy_scope = ListPolicy::Scope.new(@user, List).resolve

    assert_includes policy_scope, list_1, "authorized list is NOT accessible to user"
    # assert_includes returns 2 assertions:
    # - assertion 1: checks that the first argument is a collection to which it can be applied the method #include?
    # - assertion 2: checks if the second argument is included or not in such collection
    # output => 1 runs, 2 assertions, 0 failures, 0 errors, 0 skips

    assert_includes policy_scope, list_2, "authorized list is NOT accessible to user"

    refute_includes policy_scope, list_3, "unauthorized list is accessible to user"
  end

  def test_show
    assert_not ListPolicy.new(@user, @list).show?, "user should NOT be authorized to access the list"

    UserList.create(user: @user, list: @list, admin: false)

    assert ListPolicy.new(@user, @list).show?, "user should be authorized to access the list"
  end

  def test_create
    assert ListPolicy.new(@user, List.new).create?, "user should be authorized to create a list"
  end

  def test_update
    assert_not ListPolicy.new(@user, @list).update?, "user should NOT be authorized to update the list"

    UserList.create(user: @user, list: @list, admin: false)

    assert ListPolicy.new(@user, @list).update?, "user should be authorized to update the list"
  end

  def test_destroy
    assert_not ListPolicy.new(@user, @list).destroy?, "user should NOT be authorized to destroy the list"

    UserList.create(user: @user, list: @list, admin: false)
    assert_not ListPolicy.new(@user, @list).destroy?, "user is not admin, should NOT be authorized to destroy the list"

    UserList.where(user: @user, list: @list).first.update(admin: true)
    assert ListPolicy.new(@user, @list).destroy?, "user is admin, should be authorized to destroy the list"
  end
end
