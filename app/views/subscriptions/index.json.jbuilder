json.subscriptions do
  json.array! @subscriptions, partial: 'subscriptions/subscription', as: :subscription
end
