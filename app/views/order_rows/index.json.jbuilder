json.order_rows do
  json.array! @order_rows, partial: 'order_rows/order_row', as: :order_row
end
json.date @date