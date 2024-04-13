json.products do
  json.array! @products, partial: 'stat/products/product', as: :product
end
json.count @products.length