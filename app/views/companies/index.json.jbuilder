json.array!(@companies) do |company|
  json.extract! company, :name, :kontakt_id
  json.url company_url(company, format: :json)
end
