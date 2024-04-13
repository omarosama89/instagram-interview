json.apis do
  json.array! @apis, partial: 'apis/api', as: :api
end
