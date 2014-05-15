json.array!(@home_page_files) do |home_page_file|
  json.extract! home_page_file, :id, :name
  json.url home_page_file_url(home_page_file, format: :json)
end
