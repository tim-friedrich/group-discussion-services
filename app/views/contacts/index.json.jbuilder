json.array!(@kontakts) do |kontakt|
  json.extract! kontakt, :street, :postalcode, :town, :email, :telephone
  json.url kontakt_url(kontakt, format: :json)
end
