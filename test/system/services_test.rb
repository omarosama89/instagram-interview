require "application_system_test_case"

class ServicesTest < ApplicationSystemTestCase
  setup do
    @service = services(:one)
  end

  test "visiting the index" do
    visit services_url
    assert_selector "h1", text: "Services"
  end

  test "creating a Service" do
    visit services_url
    click_on "New Service"

    fill_in "Active", with: @service.active
    fill_in "Api", with: @service.api_id
    fill_in "Custom Comments Flag", with: @service.custom_comments_flag
    fill_in "Description", with: @service.description
    fill_in "Factor", with: @service.factor
    fill_in "Has Note", with: @service.has_note
    fill_in "Intercept", with: @service.intercept
    fill_in "Maximum", with: @service.maximum
    fill_in "Minimum", with: @service.minimum
    fill_in "Note", with: @service.note
    fill_in "Power", with: @service.power
    fill_in "Price", with: @service.price
    fill_in "Req Method", with: @service.req_method
    fill_in "S Type", with: @service.s_type
    fill_in "Sale", with: @service.sale
    fill_in "Service Family", with: @service.service_family
    fill_in "Unit", with: @service.unit
    click_on "Create Service"

    assert_text "Service was successfully created"
    click_on "Back"
  end

  test "updating a Service" do
    visit services_url
    click_on "Edit", match: :first

    fill_in "Active", with: @service.active
    fill_in "Api", with: @service.api_id
    fill_in "Custom Comments Flag", with: @service.custom_comments_flag
    fill_in "Description", with: @service.description
    fill_in "Factor", with: @service.factor
    fill_in "Has Note", with: @service.has_note
    fill_in "Intercept", with: @service.intercept
    fill_in "Maximum", with: @service.maximum
    fill_in "Minimum", with: @service.minimum
    fill_in "Note", with: @service.note
    fill_in "Power", with: @service.power
    fill_in "Price", with: @service.price
    fill_in "Req Method", with: @service.req_method
    fill_in "S Type", with: @service.s_type
    fill_in "Sale", with: @service.sale
    fill_in "Service Family", with: @service.service_family
    fill_in "Unit", with: @service.unit
    click_on "Update Service"

    assert_text "Service was successfully updated"
    click_on "Back"
  end

  test "destroying a Service" do
    visit services_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Service was successfully destroyed"
  end
end
