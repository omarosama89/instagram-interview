json.services do
  json.array! @services, partial: 'api/mob/services/service', as: :service
end
