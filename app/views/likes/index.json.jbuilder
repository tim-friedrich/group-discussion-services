json.array!(@likes) do |like|
  json.extract! like, :integer, :integer
  json.url like_url(like, format: :json)
end
