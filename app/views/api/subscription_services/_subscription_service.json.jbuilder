json.extract! subscription_service, :id, :description, :min_likes, :max_likes, :min_posts, :max_posts, :price, :unit, :factor, :power, :intercept, :sale, :req_method, :active, :sub_type, :api_id, :created_at, :updated_at
json.url subscription_service_url(subscription_service, format: :json)
