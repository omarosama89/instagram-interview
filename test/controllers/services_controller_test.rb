require 'test_helper'

class ServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service = services(:one)
  end

  test "should get index" do
    get services_url
    assert_response :success
  end

  test "should get new" do
    get new_service_url
    assert_response :success
  end

  test "should create service" do
    assert_difference('Service.count') do
      post services_url, params: { service: { active: @service.active, api_id: @service.api_id, custom_comments_flag: @service.custom_comments_flag, description: @service.description, factor: @service.factor, has_note: @service.has_note, intercept: @service.intercept, maximum: @service.maximum, minimum: @service.minimum, note: @service.note, power: @service.power, price: @service.price, req_method: @service.req_method, s_type: @service.s_type, sale: @service.sale, service_family: @service.service_family, unit: @service.unit } }
    end

    assert_redirected_to service_url(Service.last)
  end

  test "should show service" do
    get service_url(@service)
    assert_response :success
  end

  test "should get edit" do
    get edit_service_url(@service)
    assert_response :success
  end

  test "should update service" do
    patch service_url(@service), params: { service: { active: @service.active, api_id: @service.api_id, custom_comments_flag: @service.custom_comments_flag, description: @service.description, factor: @service.factor, has_note: @service.has_note, intercept: @service.intercept, maximum: @service.maximum, minimum: @service.minimum, note: @service.note, power: @service.power, price: @service.price, req_method: @service.req_method, s_type: @service.s_type, sale: @service.sale, service_family: @service.service_family, unit: @service.unit } }
    assert_redirected_to service_url(@service)
  end

  test "should destroy service" do
    assert_difference('Service.count', -1) do
      delete service_url(@service)
    end

    assert_redirected_to services_url
  end
end
