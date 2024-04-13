json.order_details do
  json.array! @order_details, partial: 'order_details/order_detail', as: :order_detail
end
json.date @date