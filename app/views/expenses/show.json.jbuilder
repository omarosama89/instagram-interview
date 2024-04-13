json.expense do
  json.partial! "expenses/expense", expense: @expense
end
