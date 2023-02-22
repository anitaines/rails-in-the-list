require "test_helper"

class UserTest < ActiveSupport::TestCase
  # setup do
  #   mark_test_start_time
  # end

  # teardown do
  #   record_test_duration
  # end

  test "invalid without first_name" do
    user = User.new(email: "test@mail.com", password: "123456")

    refute user.valid?, 'user is valid without a first_name'
    assert_not user.errors[:first_name].empty?, 'no validation error for first_name present'
  end

  test "clean_user_records method should not destroy the item the user marked as done" do
    user = users(:one)
    user.destroy

    assert_not_nil items(:one)
  end

  test "clean_user_records method should remove user's id from the item the user marked as done" do
    user = users(:one)
    user.destroy

    assert_nil items(:one).user
  end

  test "clean_user_records method should set purchased_date to nil from the item the user marked as done" do
    user = users(:one)
    user.destroy

    assert_nil items(:one).purchased_date, "item's purchased_date should be nil after destroying user"
  end

  test "clean_user_records method should set purchased to false from the item the user marked as done" do
    user = users(:one)
    user.destroy

    assert_equal items(:one).purchased, false, "item's purchased should be false after destroying user"
  end

  test "clean_user_records method should destroy its related user_lists" do
    user = users(:one)
    user.destroy

    assert_nil UserList.find_by(user: users(:one)), "all user_lists related to user should be destroyed"
    assert_not_nil UserList.find_by(user: users(:two)), "should not destroy other admin user's user_lists"
    assert_raises(ActiveRecord::RecordNotFound) { user_lists(:four) }
  end

  test "clean_user_records method should destroy only the lists the user created" do
    user = users(:one)
    user.destroy

    assert_raise(StandardError) { lists(:two) }
    assert_not_nil lists(:one)
  end
end
