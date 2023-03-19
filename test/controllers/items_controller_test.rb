require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @list = lists(:one)
    @item = items(:one)
    sign_in users(:one)
  end

  test "should create item" do
    assert_difference('Item.count') do
      post list_items_url(@list), params: { item: { name: "New Item", amount: 10 }, origin: "dashboard" }
    end
    assert_redirected_to lists_url

    assert_difference('Item.count') do
      post list_items_url(@list), params: { item: { name: "New Item B", amount: 10 }, origin: "list-tab" }
    end
    assert_redirected_to list_url(@list)

    assert_difference('Item.count') do
      post list_items_url(@list), params: { item: { name: "New Item C", amount: 10 }, origin: "usual-items-tab" }
    end
    assert_redirected_to list_url(@list)
  end

  test "should update item" do
    patch item_url(@item), params: { item: { name: "Updated Item", amount: "20" } }
    assert_redirected_to list_url(@item.list)
    @item.reload
    assert_equal "Updated Item", @item.name
    assert_equal "20", @item.amount
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete item_url(@item)
    end

    assert_redirected_to list_path(@item.list)
  end
end
