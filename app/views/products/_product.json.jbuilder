json.extract! product, :id, :name, :title, :price, :created_at, :updated_at
json.url product_url(product, format: :json)