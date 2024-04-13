require "application_system_test_case"

class OrderDetailsTest < ApplicationSystemTestCase
  setup do
    @order_detail = order_details(:one)
  end

  test "visiting the index" do
    visit order_details_url
    assert_selector "h1", text: "Order Details"
  end

  test "creating a Order detail" do
    visit order_details_url
    click_on "New Order Detail"

    fill_in "Amount", with: @order_detail.amount
    fill_in "Api Order", with: @order_detail.api_order_id
    fill_in "Link", with: @order_detail.link
    fill_in "Order Row", with: @order_detail.order_row_id
    fill_in "Status", with: @order_detail.status
    click_on "Create Order detail"

    assert_text "Order detail was successfully created"
    click_on "Back"
  end

  test "updating a Order detail" do
    visit order_details_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @order_detail.amount
    fill_in "Api Order", with: @order_detail.api_order_id
    fill_in "Link", with: @order_detail.link
    fill_in "Order Row", with: @order_detail.order_row_id
    fill_in "Status", with: @order_detail.status
    click_on "Update Order detail"

    assert_text "Order detail was successfully updated"
    click_on "Back"
  end

  test "destroying a Order detail" do
    visit order_details_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order detail was successfully destroyed"
  end
end
