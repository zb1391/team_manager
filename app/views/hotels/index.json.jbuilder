json.array!(@hotels) do |hotel|
  json.extract! hotel, :id, :name, :address, :city, :state, :price, :addtional_link
  json.url hotel_url(hotel, format: :json)
end
