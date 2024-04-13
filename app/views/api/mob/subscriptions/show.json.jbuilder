json.subscription do
  json.partial! "api/mob/subscriptions/subscription", subscription: @subscription
end
