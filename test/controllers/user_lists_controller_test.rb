require "test_helper"

class UserListsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test "destroy should delete UserList of current user (exit list)" do
    user_list = user_lists(:one)

    assert_difference('UserList.count', -1) do
      delete user_list_url(user_list)
    end

    assert_redirected_to lists_url
  end

  test "destroy should delete UserList of other user (remove user from list)" do
    user_list = user_lists(:four)

    assert_difference('UserList.count', -1) do
      delete user_list_url(user_list)
    end

    assert_redirected_to list_url(user_list.list)
  end
end
