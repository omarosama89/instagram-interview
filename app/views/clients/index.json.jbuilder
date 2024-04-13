json.clinets do
  json.array! @clients, partial: 'clients/client', as: :client
end
