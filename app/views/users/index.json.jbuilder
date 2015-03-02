json.array!(@users) do |user|
  json.extract! user, :firstname, :lastname, :email, :gender, :age, :zipcode
end
