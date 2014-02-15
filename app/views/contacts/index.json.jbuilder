json.array!(@contacts) do |kontakt|
  json.extract! kontact, :street, :postalcode, :town, :email, :telephone
  json.url contact_url(contact, format: :json)
end
