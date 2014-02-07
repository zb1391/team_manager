json.array!(@eventtypes) do |eventtype|
  json.extract! eventtype, :id, :name
  json.url eventtype_url(eventtype, format: :json)
end
