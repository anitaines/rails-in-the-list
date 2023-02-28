require 'test_helper'

class UserListPolicyTest < ActiveSupport::TestCase
  def test_destroy
    user_1 = users(:one)
    user_2 = users(:two)
    user_3 = users(:three)
    list_3 = lists(:three)

    # user is not in the list, can not destroy
    user_list_1 = UserList.create(user: user_1, list: list_3, admin: false)
    assert_not UserListPolicy.new(user_2, user_list_1).destroy?, "user should NOT be authorized to destroy the user_list"

    # user is in the list, can not remove other user who is admin
    user_list_2 = UserList.create(user: user_2, list: list_3, admin: true)
    assert_not UserListPolicy.new(user_1, user_list_2).destroy?, "user should NOT be authorized to destroy a user_list with admin true"

    # user is in the list, can remove other user
    user_list_3 = UserList.create(user: user_3, list: list_3, admin: false)
    assert UserListPolicy.new(user_2, user_list_3).destroy?, "user should be authorized to destroy a user_list (remove other user from list)"

    # user is in the list, can exit the list
    assert UserListPolicy.new(user_1, user_list_1).destroy?, "user should be authorized to destroy a user_list (exit list)"

    # user is admin, can not destroy own user_list and leave list without admin
    assert_not UserListPolicy.new(user_2, user_list_2).destroy?, "user should NOT be authorized to destroy own user_list (user itself is admin)"
  end
end
