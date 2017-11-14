json.products @products do |product|
  json.id   product.id
  json.title product.title
  json.url   product_url(product)

  
end