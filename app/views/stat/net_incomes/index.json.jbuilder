json.net_incomes do
  json.array! @net_incomes, partial: 'stat/net_incomes/net_income', as: :net_income
end
json.count @net_incomes.length
json.rate @rate
json.total_net @total_net
json.total_count @total_count
json.avg_net @avg_net
json.avg_count @avg_count
json.days_elapsed @days_elapsed