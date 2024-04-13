json.extract! subscription, :id, :username, :paid, :net, :order_code, :transaction_id, :payment_id, :posts_count, :likes_count, :status, :client_ip, :verified, :created_by_admin, :client_id, :subscription_service_id, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
