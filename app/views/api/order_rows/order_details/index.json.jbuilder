json.service_family @service_family
json.service_description @service_description
json.order_details do
  json.array! @order_details, partial: 'order_details/order_detail', as: :order_detail
end
