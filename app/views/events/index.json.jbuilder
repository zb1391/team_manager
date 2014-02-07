json.array!(@events) do |event|
  json.extract! event, :id, :event_time, :event_location, :eventtype_id, :team_id
  json.url event_url(event, format: :json)
end
