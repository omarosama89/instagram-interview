require "application_system_test_case"

class OrderRowsTest < ApplicationSystemTestCase
  setup do
    @order_row = order_rows(:one)
  end

  test "visiting the index" do
    visit order_rows_url
    assert_selector "h1", text: "Order Rows"
  end

  test "creating a Order row" do
    visit order_rows_url
    click_on "New Order Row"

    fill_in "Client", with: @order_row.client_id
    fill_in "Order Code", with: @order_row.order_code
    fill_in "Service", with: @order_row.service_id
    fill_in "Verified", with: @order_row.verified
    click_on "Create Order row"

    assert_text "Order row was successfully created"
    click_on "Back"
  end

  test "updating a Order row" do
    visit order_rows_url
    click_on "Edit", match: :first

    fill_in "Client", with: @order_row.client_id
    fill_in "Order Code", with: @order_row.order_code
    fill_in "Service", with: @order_row.service_id
    fill_in "Verified", with: @order_row.verified
    click_on "Update Order row"

    assert_text "Order row was successfully updated"
    click_on "Back"
  end

  test "destroying a Order row" do
    visit order_rows_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order row was successfully destroyed"
  end
end
