json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id, :name, :the_date, :price
  json.url tournament_url(tournament, format: :json)
end
