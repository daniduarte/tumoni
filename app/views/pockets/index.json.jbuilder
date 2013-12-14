json.array!(@pockets) do |pocket|
  json.extract! pocket, :id, :name
  json.url pocket_url(pocket, format: :json)
end
