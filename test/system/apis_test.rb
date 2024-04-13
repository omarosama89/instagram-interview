require "application_system_test_case"

class ApisTest < ApplicationSystemTestCase
  setup do
    @api = apis(:one)
  end

  test "visiting the index" do
    visit apis_url
    assert_selector "h1", text: "Apis"
  end

  test "creating a Api" do
    visit apis_url
    click_on "New Api"

    fill_in "Action Attr", with: @api.action_attr
    fill_in "Amount Attr", with: @api.amount_attr
    fill_in "Custom Comments Attr", with: @api.custom_comments_attr
    fill_in "Key", with: @api.key
    fill_in "Key Attr", with: @api.key_attr
    fill_in "Link Attr", with: @api.link_attr
    fill_in "Name", with: @api.name
    fill_in "Orderid Attr", with: @api.orderid_attr
    fill_in "Type Attr", with: @api.type_attr
    fill_in "Url", with: @api.url
    fill_in "Username", with: @api.username
    click_on "Create Api"

    assert_text "Api was successfully created"
    click_on "Back"
  end

  test "updating a Api" do
    visit apis_url
    click_on "Edit", match: :first

    fill_in "Action Attr", with: @api.action_attr
    fill_in "Amount Attr", with: @api.amount_attr
    fill_in "Custom Comments Attr", with: @api.custom_comments_attr
    fill_in "Key", with: @api.key
    fill_in "Key Attr", with: @api.key_attr
    fill_in "Link Attr", with: @api.link_attr
    fill_in "Name", with: @api.name
    fill_in "Orderid Attr", with: @api.orderid_attr
    fill_in "Type Attr", with: @api.type_attr
    fill_in "Url", with: @api.url
    fill_in "Username", with: @api.username
    click_on "Update Api"

    assert_text "Api was successfully updated"
    click_on "Back"
  end

  test "destroying a Api" do
    visit apis_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Api was successfully destroyed"
  end
end
