json.array!(@coaches) do |coach|
  json.extract! coach, :id, :first_name, :last_name, :phone, :email, :encrypted_password
  json.url coach_url(coach, format: :json)
end
