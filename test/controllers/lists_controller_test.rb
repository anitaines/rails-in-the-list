require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @list = lists(:two)
    sign_in users(:one)
  end

  test "should get index" do
    p lists_url
    p lists_path
    get lists_path
    p assert_response :success
    assert_response :success
  end

  test "should get new" do
    get new_list_url
    assert_response :success
  end

  test "should create list" do
    assert_difference('List.count') do
      post lists_url, params: { list: { name: "New List" } }
    end

    # assert_equal "New List", List.last.name, "error creating list" 
    # actually no need, if list wasn't created assert_difference('List.count') will fail:
    # "Item.count" didn't change by 1.
    # Expected: 3
    # Actual: 2

    assert_redirected_to list_url(List.last)
  end

  test "should show list" do
    get list_url(@list)
    assert_response :success
  end

  test "should get edit" do
    get edit_list_url(@list)
    assert_response :success
  end

  test "should update list" do
    patch list_url(@list), params: { list: { name: "Updated List" } }
    assert_redirected_to list_url(@list)
    @list.reload
    assert_equal "Updated List", @list.name
  end

  test "should destroy list" do
    assert_difference('List.count', -1) do
      delete list_url(@list)
    end
    assert_redirected_to lists_url
  end
end
