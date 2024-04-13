json.extract! order_row, :id, :paid, :order_code, :payment_id, :verified, :client_id, :service_id, :created_at, :updated_at
json.order_details do
  json.array! order_row.order_details, partial: 'order_details/order_detail', as: :order_detail
end
json.client do
  json.partial! order_row.client, partial: 'clients/client', as: :client unless order_row.client.nil?
end