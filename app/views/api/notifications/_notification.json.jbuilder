json.extract! notification, :id, :text, :active, :created_at, :updated_at
json.url notification_url(notification, format: :json)
