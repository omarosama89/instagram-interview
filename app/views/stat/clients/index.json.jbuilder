json.clients do
  json.array! @clients, partial: 'stat/clients/client', as: :client
end
json.count @clients.length