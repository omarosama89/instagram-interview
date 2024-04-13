json.expenses do
  json.array! @expenses, partial: 'expenses/expense', as: :expense
end
