json.array!(@movements) do |movement|
  json.extract! movement, :id, :description, :amount
  json.url movement_url(movement, format: :json)
end
