json.array!(@summer_campers) do |summer_camper|
  json.extract! summer_camper, :id, :first_name, :last_name, :address, :city, :state, :zip, :gender, :grade, :email, :home_phone, :cell_phone, :waiver_name, :waiver_date
  json.url summer_camper_url(summer_camper, format: :json)
end
