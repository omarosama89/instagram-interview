json.subscription_services do
  json.array! @subscription_services, partial: 'api/api/mob/subscription_services/subscription_service', as: :subscription_service
end
