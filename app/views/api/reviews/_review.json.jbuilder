json.extract! review, :id, :message, :rate, :client_id, :created_at, :updated_at
json.url review_url(review, format: :json)
