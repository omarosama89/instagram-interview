json.extract! service, :id, :description, :minimum, :maximum, :price, :unit, :factor, :power, :intercept, :sale, :has_note, :note, :req_method, :active, :service_family, :custom_comments_flag, :api_id, :created_at, :updated_at
json.url service_url(service, format: :json)
