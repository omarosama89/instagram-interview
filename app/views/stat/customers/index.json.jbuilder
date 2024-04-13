json.customers do
  json.array! @customers, partial: 'stat/customers/customer', as: :customer
end
json.count @customers.length