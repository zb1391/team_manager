json.array!(@summer_camps) do |summer_camp|
  json.extract! summer_camp, :id, :start_date, :end_date, :price
  json.url summer_camp_url(summer_camp, format: :json)
end
