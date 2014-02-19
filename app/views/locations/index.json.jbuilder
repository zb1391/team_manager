json.array!(@locations) do |location|
  json.extract! location, :id, :name, :address, :city, :state, :additional_link
  json.url location_url(location, format: :json)
end
