json.extract! order_row, :id, :paid, :order_code, :transaction_id, :payment_id, :client_ip, :verified, :created_by_admin, :client_id, :service_id, :created_at, :updated_at
json.order_details do
  json.array! order_row.order_details, partial: 'order_details/order_detail', as: :order_detail
end